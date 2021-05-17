import UIKit

// MARK: - Protocol

protocol CharactersCoordinatorType {
    func start(on window: UIWindow)
}

// MARK: - Implementation

final class CharactersCoordinator {

    private let charactersRepository: CharacterRepositoryType
    private let characterCoordinator: CharacterCoordinatorType

    private weak var navigationController: UINavigationController?

    init(charactersRepository: CharacterRepositoryType,
         characterCoordinator: CharacterCoordinatorType) {
        self.charactersRepository = charactersRepository
        self.characterCoordinator = characterCoordinator
    }

}

// MARK: - CharactersCoordinator + CharactersCoordinatorType

extension CharactersCoordinator: CharactersCoordinatorType {

    func start(on window: UIWindow) {
        let viewController = CharactersViewController()
        let viewModel = CharactersViewModel(charactersRepository: charactersRepository)
        viewController.viewModel = viewModel
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }

}

// MARK: - CharactersCoordinator + CharactersViewControllerDelegate

extension CharactersCoordinator: CharactersViewControllerDelegate {

    func didSelect(character: Character) {
        guard let navigationController = navigationController else { return }
        characterCoordinator.start(on: navigationController, with: character)
    }

}
