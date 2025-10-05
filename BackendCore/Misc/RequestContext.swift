//
//  RequestContext.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import NetworkingCore

public class RequestContext {
    public let request: HttpRequest
    public var response: HttpResponse?
    public var route: PRoute?
    
    public init(request: HttpRequest, response: HttpResponse? = nil, route: PRoute? = nil) {
        self.request = request
        self.response = response
        self.route = route
    }
}
