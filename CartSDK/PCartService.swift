//
//  PCartService.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import CartCore
import RxSwift

public protocol PCartService: CartCore.PCartService {
    var cartObservable: Observable<Cart> { get }
    
    func loadCart();
}
