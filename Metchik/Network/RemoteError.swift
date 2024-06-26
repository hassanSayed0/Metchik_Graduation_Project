//
//  RemoteError.swift
//  Metchik
//
//  Created by Hassan on 29/04/2024.
//

import Foundation

public enum RemoteError: Error {
    case detectError(statusCode: Int)
    case authMessage(message: String)
    public var description: String {
        switch self {
        case .detectError(let statusCode):
            return chooseFromCommonErrors(statusCode: statusCode)
        case .authMessage(let message):
            return message
        }
    }
    
   private func chooseFromCommonErrors(statusCode: Int) -> String {
        switch statusCode {
        case 200: return "Request succeeded"
        case 201: return "Created"
        case 400: return "Request syntax is invalid"
        case 401: return "Authentication failed, please provide valid credentials"
        case 403: return "Access to resource is forbidden"
        case 404: return "server not found try again later"
        case 500: return "Internal server error, please try again later"
        case 502: return "Bad gateway, upstream server returned an invalid response"
        case 503: return "Service is currently unavailable, please try again later"
        default:
            return "Some thing went wrong!"
        }
    }
}
