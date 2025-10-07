//
//  CheckoutViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import RxSwift
import CartSDK
import CartCore

protocol PCheckoutViewModel {
    var titleObservable: Observable<String> { get }
    var iconObservable: Observable<UIImage?> { get }
    var sectionItemsObservable: Observable<[CheckoutSectionItem]> { get }
    var currentCurrencyObservable: Observable<Currency> { get }
    var availableCurrenciesObservable: Observable<[Currency]> { get }
    func onChangeCurrency(_ currency: Currency)
    func onViewLoaded()
    func onFinishTapped()
}

class CheckoutViewModel: PCheckoutViewModel, PHasDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    let titleObservable = Observable.just("Checkout")
    let iconObservable = Observable.just(UIImage(systemName: "list.bullet.clipboard")?.withRenderingMode(.alwaysOriginal))
    
    @Inject(.enclosingInstance)
    private var cartService: CartSDK.PCartService
    @Inject(.enclosingInstance)
    private var currenciesService: CartSDK.PCurrenciesService
    
    var availableCurrenciesObservable: Observable<[Currency]> { currenciesService.availableCurrenciesObservable }
    var currentCurrencyObservable: Observable<Currency> { currenciesService.currentCurrencyObservable }
    var sectionItemsObservable: Observable<[CheckoutSectionItem]> { sectionItemsSubject }
    var sectionItemsSubject: PublishSubject<[CheckoutSectionItem]>
    
    private let coordinator: PCheckoutCoordinator
    private let checkoutSummary: CheckoutSummary
    private let disposeBag: DisposeBag
    
    init(diContainer: DependencyInjection.PDIContainer, coordinator: PCheckoutCoordinator, checkoutSummary: CheckoutSummary) {
        self.diContainer = diContainer
        self.coordinator = coordinator
        self.sectionItemsSubject = PublishSubject<[CheckoutSectionItem]>()
        self.checkoutSummary = checkoutSummary
        self.disposeBag = DisposeBag()
    }
    
    func onViewLoaded() {
        currentCurrencyObservable
            .subscribe(onNext: { [weak self] currentCurrency in
                Task {
                    guard let self = self else { return }
                    let conversionRate = try await self.currenciesService.getConversionRate(fromCurrency:
                                                                                                self.checkoutSummary.totalPrice.currency, toCurrency: currentCurrency)
                    var items = self.checkoutSummary.checkoutSummaryItems.map {
                        let quantityString = String(format: "%i \($0.unit)", $0.quantity)
                        let price = $0.price.value * conversionRate
                        let priceString = String(format: "%.2f \(currentCurrency)", price)
                        return CheckoutSectionItem.item(CheckoutItemViewModel(offerId: $0.offerId, name: $0.name, price: priceString, quantityString: quantityString))
                    }
                    let price = self.checkoutSummary.totalPrice.value * conversionRate
                    let priceString = String(format: "%.2f \(currentCurrency)", price)
                    items.append(.summary(CheckoutSummaryViewModel(uniqueItemsInCartTitle: "Unique items:", uniqueItemsInCartValue: "\(items.count)", totalPriceTitle: "Total price:", totalPriceValue: priceString)))
                    self.sectionItemsSubject.onNext(items)
                }
            }).disposed(by: disposeBag)
    }
    
    func onFinishTapped() {
        Task { [weak self] in
            try await self?.cartService.clearCart()
            self?.coordinator.goToResult()
        }
    }
    
    func onChangeCurrency(_ currency: CartCore.Currency) {
        currenciesService.pickCurrency(currency: currency)
    }
}
