//
//  CartViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import RxSwift
import DependencyInjection
import CartSDK
import CartCore

protocol PCartViewModel {
    var titleObservable: Observable<String> { get }
    var iconObservable: Observable<UIImage?> { get }
    var stateObservable: Observable<CartViewState> { get }
    var currentCurrencyObservable: Observable<Currency> { get }
    var availableCurrenciesObservable: Observable<[Currency]> { get }

    func onViewLoaded()
    func onClearCartTapped()
    func onGoToCheckoutTapped()
    func onAddToCartTapped(cartItem: CartItem)
    func onRemoveFromCartTapped(cartItem: CartItem)
    func onChangeCurrency(_ currency: Currency)
}

class CartViewModel: PCartViewModel, PHasDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    @Inject(.enclosingInstance)
    private var cartService: CartSDK.PCartService
    @Inject(.enclosingInstance)
    private var offersService: CartSDK.POffersService
    @Inject(.enclosingInstance)
    private var currenciesService: CartSDK.PCurrenciesService
    
    let titleObservable = Observable.just("Cart")
    let iconObservable = Observable.just(UIImage(systemName: "cart")?.withRenderingMode(.alwaysOriginal))
    var stateObservable: Observable<CartViewState> { stateSubject }
    var availableCurrenciesObservable: Observable<[Currency]> { currenciesService.availableCurrenciesObservable }
    var currentCurrencyObservable: Observable<Currency> { currenciesService.currentCurrencyObservable }

    
    private let stateSubject = BehaviorSubject(value: CartViewState.empty(caption: "Cart is empty"))
    private var disposeBag = DisposeBag()
    private let coordinator: PCartCoordinator

    
    required init(diContainer: DependencyInjection.PDIContainer, coordinator: PCartCoordinator) {
        self.diContainer = diContainer
        self.coordinator = coordinator
    }
    
    func onViewLoaded() {
        Observable.combineLatest(cartService.cartObservable, currenciesService.currentCurrencyObservable)
            .subscribe(onNext: { [weak self] cart, currentCurrency in
                guard let cart = cart, !cart.cartItems.isEmpty else {
                    self?.stateSubject.onNext(.empty(caption: "Cart is empty"))
                    return
                }
                self?.stateSubject.onNext(.loadingOffers(cart))
                Task {
                    guard let self = self else { return }
                    let conversionRate = try await self.currenciesService.getConversionRate(fromCurrency: cart.totalPrice.currency, toCurrency: currentCurrency)
                    let offers = try await self.offersService.getOffers(offerIds: cart.cartItems.map { $0.offerId })
                    let quantitiesDict = Dictionary(uniqueKeysWithValues: cart.cartItems.map { ($0.offerId, $0.quantity) })
                    let totalPriceString = String(format: "%.2f", cart.totalPrice.value * conversionRate)
                    let itemViewModels = offers.map {
                        let quantity = quantitiesDict[$0.offerId]!
                        let quantityString = String(format: "%i", quantity)
                        let itemPriceString = String(format: "%.2f", $0.price.value * conversionRate * Double(quantity))
                        let vm = CartItemViewModel(offer: $0, name: $0.name, price: "\(itemPriceString) \(currentCurrency)", quantityString: "\(quantityString) \($0.unit)", quantity: Double(quantity))
                        return vm
                    }
                    var sectionItems = itemViewModels.map { CartSectionItem.item($0) }
                    let summary = CartSummaryViewModel(uniqueItemsInCartTitle: "Unique items in cart:", uniqueItemsInCartValue: "\(cart.cartItems.count)", totalPriceTitle: "Total price:", totalPriceValue: "\(totalPriceString) \(currentCurrency)")
                    sectionItems.append(.summary(summary))
                    self.stateSubject.onNext(.content(cart, sectionItems))
                }
            }).disposed(by: disposeBag)
        stateSubject.onNext(.loading)
        cartService.loadCart()
    }
    
    func onClearCartTapped() {
        Task { [weak self] in
            try await self?.cartService.clearCart()
        }
    }
    
    func onGoToCheckoutTapped() {
        cartService.cartObservable
            .single()
            .subscribe(onNext: { [weak self] cart in
                guard let cart = cart, !cart.cartItems.isEmpty else {return }
                Task {
                    guard let self = self else { return }
                    let offers = try await self.offersService.getOffers(offerIds: cart.cartItems.map { $0.offerId })
                    let quantitiesDict = Dictionary(uniqueKeysWithValues: cart.cartItems.map { ($0.offerId, $0.quantity) })
                    let summaryItems = offers.map {
                        let quantity = quantitiesDict[$0.offerId]!
                        let itemsPrice = $0.price.value * Double(quantity)
                        return CheckoutSummaryItem(offerId: $0.offerId, name: $0.name, price: Price(value: itemsPrice, currency: $0.price.currency), unit: $0.unit, quantity: quantity)
                    }
                    let summary = CheckoutSummary(checkoutSummaryItems: summaryItems, totalPrice: cart.totalPrice)
                    self.coordinator.goToCheckout(summary: summary)
                }
            }).disposed(by: disposeBag)
    }
    
    func onAddToCartTapped(cartItem: CartItem) {
        Task { [weak self] in
            try await self?.cartService.addToCart(cartItem: cartItem)
        }
    }
    
    func onRemoveFromCartTapped(cartItem: CartItem) {
        Task { [weak self] in
            try await self?.cartService.removeFromCart(cartItem: cartItem)
        }
    }
    
    func onChangeCurrency(_ currency: CartCore.Currency) {
        currenciesService.pickCurrency(currency: currency)
    }
}

