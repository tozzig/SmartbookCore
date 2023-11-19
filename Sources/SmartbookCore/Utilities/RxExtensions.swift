import RxCocoa
import RxSwift

public extension ObservableConvertibleType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}

public extension ObservableType {
    func mapTo<Result>(_ value: Result) -> Observable<Result> {
        map { _ in value }
    }
}

public extension ObservableType {
    func filterBy<Source: ObservableConvertibleType>(
        _ filterObservable: Source,
        filterSelector: @escaping (Source.Element) -> Bool
    ) -> Observable<Element> {
        withLatestFrom(filterObservable) { ($0, $1) }
            .filter { filterSelector($0.1) }
            .map { $0.0 }
    }

    func toOptional() -> Observable<Element?> {
        map(Optional.init)
    }
}


public extension PrimitiveSequence where Trait == SingleTrait {
    func toOptional() -> Single<Element?> {
        map(Optional.init)
    }
}

public extension SharedSequence where SharingStrategy == DriverSharingStrategy {
    func toOptional() -> Driver<Element?> {
        map(Optional.init)
    }
}
