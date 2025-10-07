//
//  CartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import CartCore
import DependencyInjection
import HttpClient
import RxSwift

public class CartService: PCartService, PInitiableWithDIContainer, PHasDIContainer {
    public let cartObservable: Observable<Cart?>
    private let cartSubject: BehaviorSubject<Cart?>
    
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var apiClient: PAuthorizedCartClient
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
        cartSubject = BehaviorSubject(value: nil)
        cartObservable = cartSubject.asObservable()
    }
    
    public func loadCart() {
        Task {
            try await getCart()
        }
    }
    
    public func getCart() async throws -> CartCore.Cart {
        let cart: Cart = try await apiClient.get(path: "/cart")
        cartSubject.onNext(cart)
        return cart
    }
    
    public func addToCart(cartItem: CartItem) async throws -> Bool {
        // modify locally to preview changes
        if let oldCart = try? cartSubject.value() {
            let newCart = CartHelper.add(toCart: oldCart, cartItem: cartItem)
            cartSubject.onNext(newCart)
        }
        let success: Bool = try await apiClient.post(path: "/cart/item", payload: cartItem)
        _ = try await getCart()
        return success
    }
    
    public func removeFromCart(cartItem: CartCore.CartItem) async throws {
        // modify locally to preview changes
        if let oldCart = try? cartSubject.value() {
            let newCart = CartHelper.remove(fromCart: oldCart, cartItem: cartItem)
            cartSubject.onNext(newCart)
        }
        _ = try await apiClient.delete(path: "/cart/item", payload: cartItem)
        _ = try await getCart()
    }
    
    public func clearCart() async throws {
        let cart = Cart(cartId: UUID(), cartItems: [], totalPrice: .init(value: 0.0, currency: .USD))
        cartSubject.onNext(cart)
        _ = try await apiClient.delete(path: "/cart")
        _ = try await getCart()
    }
}
