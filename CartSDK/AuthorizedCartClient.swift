//
//  AuthorizedCartClient.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation
import NetworkingCore
import HttpClient

public class AuthorizedCartClient: RestApiClient, PAuthorizedCartClient {
    public init(requester: PHttpRequester) {
        let interceptors: [PInterceptor] = [
            
        ]
        super.init(requester: requester, interceptors: interceptors, encoder: JSONEncoder(), decoder: JSONDecoder(), requestContentType: ContentTypes.applicationJson)
    }
}
