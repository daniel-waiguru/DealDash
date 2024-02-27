//
//  ResultWrapper.swift
//  DealDash
//
//  Created by Daniel Waiguru on 18/02/2024.
//

import Foundation
enum ResultWrapper<T>: Equatable where T: Equatable {
    case loading, empty
    case success(data: T)
    case error(error: DealDashError)
    
    var hasError: Bool {
            if case .error = self {
                return true
            } else {
                return false
            }
        }
    var errorMessage: DealDashError? {
            if case let .error(message) = self {
                return message
            } else {
                return nil
            }
        }
    
    static func == (lhs: ResultWrapper<T>, rhs: ResultWrapper<T>) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.empty, .empty):
                return true
            case let (.success(data: leftData), .success(data: rightData)):
                return leftData == rightData
            case let (.error(leftError), .error(rightError)):
                return leftError == rightError
            default:
                return false
            }
        }
    
}


enum DealDashError: LocalizedError, Equatable {
    case networking(error: LocalizedError)
    case system(error: Error)
    case appError(error: String)
    
    static func == (lhs: DealDashError, rhs: DealDashError) -> Bool {
            switch (lhs, rhs) {
            case let (.networking(error1), .networking(error2)):
                return error1.localizedDescription == error2.localizedDescription
            case let (.system(error1), .system(error2)):
                return (error1 as NSError) == (error2 as NSError)
            case let (.appError(error1), .appError(error2)):
                return error1 == error2
            default:
                return false
            }
        }
}

extension DealDashError {
    var errorDescription: String? {
        switch self {
        case .networking(let error):
            return error.errorDescription

        case .system(let error):
            return error.localizedDescription
        case .appError(let error):
            return error
        }
    }
}
