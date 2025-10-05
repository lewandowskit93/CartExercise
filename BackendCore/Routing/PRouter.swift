//
//  PRouter.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public protocol PRouter {
    func route(context: RequestContext) throws
}
