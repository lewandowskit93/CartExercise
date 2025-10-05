//
//  HttpStatusCode.swift
//  CartExercise
//
//  Created by Tomasz Lewandowski on 05/10/2025.
//

public enum HttpStatusCode: Int, RawRepresentable {
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case badRequest = 400
    case unauthrorized = 401
    case notFound = 404
    case unsupportedMediaType = 415
    case internalServerError = 500
}

public extension HttpStatusCode {
    var isSuccess: Bool {
        get {
            switch(self) {
            case .ok, .created, .accepted, .noContent:
                return true
            default:
                return false
            }
        }
    }
    
    var isClientError: Bool {
        get {
            switch(self) {
            case .badRequest, .unauthrorized, .notFound, .unsupportedMediaType:
                return true
            default:
                return false
            }
        }
    }
    
    var isServerError: Bool {
        get {
            switch(self) {
            case .internalServerError:
                return true
            default:
                return false
            }
        }
    }
}
