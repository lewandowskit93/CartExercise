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
    public let cartObservable: Observable<Cart>
    private let cartSubject: ReplaySubject<Cart>
    
    public let diContainer: PDIContainer
    
    @Inject(.enclosingInstance)
    private var apiClient: PAuthorizedCartClient
    
    public required init(diContainer: PDIContainer) {
        self.diContainer = diContainer
        cartSubject = ReplaySubject<Cart>.create(bufferSize: 1)
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
}
