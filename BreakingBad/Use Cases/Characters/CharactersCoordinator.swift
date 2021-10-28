import Resolver
import UIKit

// MARK: - Protocol

protocol CharactersCoordinatorType {
    func start(on window: UIWindow)
}

// MARK: - Implementation

final class CharactersCoordinator {

    @Injected
    private var characterCoordinator: CharacterCoordinatorType

    private weak var navigationController: UINavigationController?

}

// MARK: - CharactersCoordinatorType

extension CharactersCoordinator: CharactersCoordinatorType {

    func start(on window: UIWindow) {
        let viewController = CharactersViewController()
        let viewModel = CharactersViewModel()
        viewController.viewModel = viewModel
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }

}

// MARK: - CharactersViewControllerDelegate

extension CharactersCoordinator: CharactersViewControllerDelegate {

    func didSelect(character: Character) {
        guard let navigationController = navigationController else { return }
        characterCoordinator.start(on: navigationController, with: character)
    }

}
