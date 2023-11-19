//
//  NetworkService.swift
//  
//
//  Created by Anton Tsikhanau on 5.08.23.
//

import Foundation
import Alamofire
import RxSwift

private enum NetworkError: Int, LocalizedError {
    case unknownError = 533
    case internalServerError = 500

    var errorDescription: String? {
        switch self {
        case .unknownError:
            return R.string.localizable.unknownError()
        case .internalServerError:
            return R.string.localizable.internalServerError()
        }
    }
}

open class NetworkService<Request: RequestProtocol> {
    private let networkProvider: NetworkProviderProtocol

    public init(networkProvider: NetworkProviderProtocol) {
        self.networkProvider = networkProvider
    }

    open func request<T: Decodable>(_ request: Request) -> Single<T> {
        networkProvider.request(request: request).filterNetworkErrors()
    }
}

private extension PrimitiveSequence {
    func filterNetworkErrors() -> Self {
        self.catch { error -> Self in
            guard
                let afError = error as? AFError,
                case .responseValidationFailed(reason: .unacceptableStatusCode(code: let code)) = afError,
                let networkError = NetworkError(rawValue: code)
            else {
                throw error
            }
            throw networkError
        }
    }
}
