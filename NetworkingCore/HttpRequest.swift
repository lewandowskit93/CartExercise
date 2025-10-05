//
//  HttpRequest.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

public struct HttpRequest {
    public let url: String
    public let method: HttpMethod
    public let headers: Dictionary<String, String>
    public var contentType: String? {
        get {
            return headers[HttpHeader.contentType.rawValue]
        }
    }
    public let payload: Data?
    
    public init(url: String, method: HttpMethod, headers: Dictionary<String, String> = .init(), contentType: String? = nil, payload: Data? = nil) {
        self.url = url
        self.method = method
        var mutableHeaders = headers
        if let contentType = contentType {
            mutableHeaders[HttpHeader.contentType.rawValue] = contentType
        } else {
            mutableHeaders.removeValue(forKey: HttpHeader.contentType.rawValue)
        }
        self.headers = mutableHeaders
        self.payload = payload
    }
    
    public func with(url: String) -> HttpRequest {
        return HttpRequest(url: url, method: method, headers: headers, contentType: contentType, payload: payload)
    }
    
    public func with(headers: Dictionary<String, String>) -> HttpRequest {
        return HttpRequest(url: url, method: method, headers: headers, contentType: contentType, payload: payload)
    }
    
    public func with(payload: Data, contentType: String) -> HttpRequest {
        return HttpRequest(url: url, method: method, headers: headers, contentType: contentType, payload: payload)
    }
    
    public func withRemovedPayload() -> HttpRequest {
        return HttpRequest(url: url, method: method, headers: headers, contentType: nil, payload: nil)

    }
}
