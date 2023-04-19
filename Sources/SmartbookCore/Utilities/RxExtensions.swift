import RxCocoa
import RxSwift

public extension ObservableConvertibleType {
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { _ in .empty() }
    }
}
