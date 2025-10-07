//
//  ShopViewModel.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 06/10/2025.
//

import DependencyInjection
import RxSwift
import CartCore
import CartSDK

protocol PShopViewModel {
    var titleObservable: Observable<String> { get }
    var iconObservable: Observable<UIImage?> { get }
    var appStyleObservable: Observable<PAppStyle> { get }
    var offersObservable: Observable<[ShopItemViewModel]> { get }

    func onViewLoaded()
    func addToCart(offer: Offer)
}

class ShopViewModel: PShopViewModel, PHasDIContainer, PInitiableWithDIContainer {
    let diContainer: any DependencyInjection.PDIContainer
    
    let titleObservable = Observable.just("Shop")
    let iconObservable = Observable.just(UIImage(systemName: "bag")?.withRenderingMode(.alwaysOriginal))
    var offersObservable: Observable<[ShopItemViewModel]> { offersSubject }
    var appStyleObservable:  Observable<PAppStyle>  { appStyleSubject }
    let appStyleSubject = ReplaySubject<PAppStyle>.create(bufferSize: 1)
    let offersSubject = BehaviorSubject<[ShopItemViewModel]>(value: [])
    
    @Inject(.enclosingInstance)
    private var appStyle: PAppStyle
    @Inject(.enclosingInstance)
    private var offersService: CartSDK.POffersService
    @Inject(.enclosingInstance)
    private var cartService: CartSDK.PCartService
    
    required init(diContainer: DependencyInjection.PDIContainer) {
        self.diContainer = diContainer
    }
    
    func onViewLoaded() {
        appStyleSubject.onNext(appStyle)
        Task {
            let offers = try await offersService.getAllOffers()
            offersSubject.onNext(offers.map {
                let priceValue = String(format: "%.2f", $0.price.value)
                let price = "\(priceValue) \($0.price.currency) per \($0.unit)"
                let stock = $0.availableUnits > 0 ? "Left in stock: \($0.availableUnits)" : "Out of stock"
                return ShopItemViewModel(offer: $0, name: $0.name, price: price, stock: stock, addToCartButtonVisible: $0.availableUnits > 0, addToCartButtonTitle: "Add to cart", addToCartButtonIcon: UIImage(systemName: "cart"))
            })
        }
    }
    
    func addToCart(offer: CartCore.Offer) {
        Task {
            try await cartService.addToCart(cartItem: CartItem(offerId: offer.offerId, quantity: 1))
        }
    }
}
