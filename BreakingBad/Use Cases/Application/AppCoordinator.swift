import Resolver
import UIKit

// MARK: - Protocol

protocol AppCoordinatorType {
    func start(on window: UIWindow)
}

// MARK: - Concrete Class

final class AppCoordinator {

    @Injected
    private var charactersCoordinator: CharactersCoordinatorType

}

// MARK: - AppCoordinatorType

extension AppCoordinator: AppCoordinatorType {

    func start(on window: UIWindow) {
        window.backgroundColor = UIColor.systemBackground
        charactersCoordinator.start(on: window)
        window.makeKeyAndVisible()
    }

}
