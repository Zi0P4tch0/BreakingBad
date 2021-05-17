import UIKit

// MARK: - Protocol

protocol AppCoordinatorType {
    func start(on window: UIWindow)
}

// MARK: - Implementation

final class AppCoordinator {

    private let charactersCoordinator: CharactersCoordinatorType

    init(charactersCoordinator: CharactersCoordinatorType) {
        self.charactersCoordinator = charactersCoordinator
    }

}

// MARK: - AppCoordinator + AppCoordinatorType

extension AppCoordinator: AppCoordinatorType {

    func start(on window: UIWindow) {
        window.backgroundColor = UIColor.systemBackground
        charactersCoordinator.start(on: window)
        window.makeKeyAndVisible()
    }

}
