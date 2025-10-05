//
//  UnauthorizedCartClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import HttpClient
import NetworkingCore
import Foundation

public class UnauthorizedCartClient: RestApiClient, PUnauthorizedCartClient {
    public init(requester: PHttpRequester) {
        let interceptors: [PInterceptor] = [
            
        ]
        super.init(requester: requester, interceptors: interceptors, encoder: JSONEncoder(), decoder: JSONDecoder(), requestContentType: ContentTypes.applicationJson)
    }
}

