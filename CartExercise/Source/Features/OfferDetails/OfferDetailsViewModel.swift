//
//  OfferDetailsViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import RxSwift
import CartCore
import CartSDK

protocol POfferDetailsViewModel {
    var titleObservable: Observable<String> { get }
    var itemNameObservable: Observable<String> { get }
    var itemDescriptionTitleObservable: Observable<String> { get }
    var stockObservable: Observable<String> { get }
    var outOfStockObservable: Observable<Bool> { get }
    var inStockCountObservable: Observable<Double> { get }
    var itemDescriptionObservable: Observable<String> { get }
    var itemPriceObservable: Observable<String> { get }
    var itemUnitObservable: Observable<String> { get }
    var itemCurrencyObservable: Observable<String> { get }
    var addToCartButtonTitleObservable: Observable<String> { get }
    var addToCartButtonImageObservable: Observable<UIImage?> { get }

    func onAddToCartTapped(quantity: Double)
    
    func onViewLoaded()
}

class OfferDetailsViewModel: POfferDetailsViewModel, PHasDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    var titleObservable: Observable<String> { titleSubject }
    var itemNameObservable: Observable<String> { itemNameSubject }
    var itemDescriptionTitleObservable: Observable<String> { Observable.just("Description") }
    var stockObservable: Observable<String> { stockSubject }
    var outOfStockObservable: Observable<Bool> { outOfStockSubject }
    var inStockCountObservable: Observable<Double> { inStockCountSubject }
    var itemDescriptionObservable: Observable<String> { itemDescriptionSubject }
    var itemPriceObservable: Observable<String> { itemPriceSubject }
    var itemUnitObservable: Observable<String> { itemUnitSubject }
    var itemCurrencyObservable: Observable<String> { itemCurrencySubject }
    var addToCartButtonTitleObservable: Observable<String> { Observable.just("Add to cart")  }
    var addToCartButtonImageObservable: Observable<UIImage?> { Observable.just(UIImage(systemName: "cart"))  }


    private let titleSubject = BehaviorSubject(value: "Offer details")
    private let itemNameSubject = BehaviorSubject(value: "Unknown name")
    private let itemDescriptionSubject = BehaviorSubject(value: "Unknown description")
    private let stockSubject = BehaviorSubject(value: "Out of stock")
    private let outOfStockSubject = BehaviorSubject(value: true)
    private let inStockCountSubject = BehaviorSubject(value: 0.0)
    private let itemPriceSubject = BehaviorSubject(value: "0.00")
    private let itemCurrencySubject = BehaviorSubject(value: "Unknown currency")
    private let itemUnitSubject = BehaviorSubject(value: "Unknown unit")

    @Inject(.enclosingInstance)
    private var offersService: CartSDK.POffersService
    
    @Inject(.enclosingInstance)
    private var cartService: CartSDK.PCartService
    
    private let offer: Offer
    
    init(diContainer: DependencyInjection.PDIContainer, offer: Offer) {
        self.diContainer = diContainer
        self.offer = offer
        titleSubject.onNext(offer.name)
        itemNameSubject.onNext(offer.name)
        let priceValue = String(format: "%.2f", offer.price.value)
        let price = "\(priceValue) \(offer.price.currency) per \(offer.unit)"
        itemPriceSubject.onNext(price)
        itemCurrencySubject.onNext(offer.price.currency.rawValue)
        itemUnitSubject.onNext(offer.unit.rawValue)
        inStockCountSubject.onNext(Double(offer.availableUnits))
        stockSubject.onNext(offer.availableUnits > 0 ? "Left in stock: \(offer.availableUnits)" : "Out of stock")
        outOfStockSubject.onNext(offer.availableUnits <= 0)
    }
    
    func onViewLoaded() {
        loadDetails()
    }
    
    func onAddToCartTapped(quantity: Double) {
        Task {
            try await cartService.addToCart(cartItem: CartItem(offerId: offer.offerId, quantity: Int(quantity)))
        }
    }
    
    private func loadDetails() {
        Task {
            let offerDetails = try await offersService.getOfferDetails(offerId: offer.offerId)
            titleSubject.onNext(offerDetails.name)
            itemNameSubject.onNext(offerDetails.name)
            itemDescriptionSubject.onNext(offerDetails.description)
            let priceValue = String(format: "%.2f", offerDetails.price.value)
            let price = "\(priceValue) \(offerDetails.price.currency) per \(offerDetails.unit)"
            itemPriceSubject.onNext(price)
            stockSubject.onNext(offerDetails.availableUnits > 0 ? "Left in stock: \(offerDetails.availableUnits)" : "Out of stock")
            outOfStockSubject.onNext(offerDetails.availableUnits <= 0)
            itemCurrencySubject.onNext(offerDetails.price.currency.rawValue)
            itemUnitSubject.onNext(offerDetails.unit.rawValue)
        }
    }
}
