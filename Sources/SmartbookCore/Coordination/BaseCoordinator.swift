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

    open func coordinate<T>(
        to coordinator: BaseCoordinator<T>,
        nextScene: SceneProtocol? = nil,
        animated: Bool = true
    ) -> Driver<T> {
        store(coordinator: coordinator)
        return coordinator.start(nextScene: nextScene, animated: animated)
            .do { [weak self] _ in
                self?.free(coordinator: coordinator)
            }
    }

    open func start(nextScene: SceneProtocol? = nil, animated: Bool = true) -> Driver<ResultType> {
        fatalError("Start method should be implemented.")
    }
}
