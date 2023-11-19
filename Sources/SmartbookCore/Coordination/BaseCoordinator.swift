import Foundation
import RxCocoa
import RxSwift

public protocol SceneProtocol {

}

open class BaseCoordinator<ResultType> {
    public let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    public init() { }

    public func coordinate<T>(
        to coordinator: BaseCoordinator<T>,
        nextScene: SceneProtocol? = nil,
        animated: Bool = true
    ) -> Driver<T> {
        store(coordinator: coordinator)
        return coordinator.start(nextScene: nextScene, animated: animated)
            .do { [weak self, weak coordinator] _ in
                if let coordinator {
                    self?.free(coordinator: coordinator)
                }
            }
    }

    open func start(nextScene: SceneProtocol? = nil, animated: Bool = true) -> Driver<ResultType> {
        fatalError("Start method should be implemented.")
    }

    deinit {
        print("Deinit of \(Self.self)")
    }
}
