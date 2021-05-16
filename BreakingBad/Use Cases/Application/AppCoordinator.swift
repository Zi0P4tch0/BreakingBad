import UIKit

protocol AppCoordinatorType {
    func start(on window: UIWindow)
}

final class AppCoordinator {

    private let charactersCoordinator: CharactersCoordinatorType

    init(charactersCoordinator: CharactersCoordinatorType) {
        self.charactersCoordinator = charactersCoordinator
    }

}

extension AppCoordinator: AppCoordinatorType {

    func start(on window: UIWindow) {
        window.backgroundColor = UIColor.systemBackground
        charactersCoordinator.start(on: window)
        window.makeKeyAndVisible()
    }

}
