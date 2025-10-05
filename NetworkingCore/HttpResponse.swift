//
//  HttpResponse.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

import Foundation

public struct HttpResponse {
    public let statusCode: HttpStatusCode
    public let headers: Dictionary<String, String>
    public var contentType: String? {
        get {
            return headers[HttpHeader.contentType.rawValue]
        }
    }
    public let content: Data?
    
    public init(
        statusCode: HttpStatusCode,
        headers: Dictionary<String, String> = .init(),
        contentType: String? = nil,
        content: Data? = nil)
    {
        self.statusCode = statusCode
        var mutableHeaders = headers
        if let contentType = contentType {
            mutableHeaders[HttpHeader.contentType.rawValue] = contentType
        } else {
            mutableHeaders.removeValue(forKey: HttpHeader.contentType.rawValue)
        }
        self.headers = mutableHeaders
        self.content = content
    }
}
