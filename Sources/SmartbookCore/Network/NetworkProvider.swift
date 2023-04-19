import Alamofire
import Foundation
import RxAlamofire
import RxSwift

public protocol NetworkProviderProtocol {
    func request<T: Decodable>(request: RequestProtocol) -> Single<T>
}

public final class NetworkProvider: NetworkProviderProtocol {
    private let requestTimeout: TimeInterval = 60

    private(set) lazy var session: Session = {
        let configuartion = URLSessionConfiguration.default
        configuartion.timeoutIntervalForRequest = requestTimeout
        return Session(configuration: .default)
    }()

    public func request<T: Decodable>(request: RequestProtocol) -> Single<T> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dataRequest = session.request(
            request.baseURL.appendingPathComponent(request.path),
            method: request.method,
            parameters: request.parameters,
            encoding: request.paramsEncoding,
            headers: request.headers
        )
        return dataRequest.rx.decodable(decoder: decoder)
            .asSingle()
            .subscribe(on: Scheduler.network)
            .observe(on: Scheduler.network)
    }
}

private enum Scheduler {
    static let network: ImmediateSchedulerType = {
        let operationQueue = OperationQueue()
        let maxConcurrentOperationCount = 4
        operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount
        operationQueue.qualityOfService = .userInitiated
        operationQueue.name = "IO"
        return OperationQueueScheduler(operationQueue: operationQueue)
    }()
}
