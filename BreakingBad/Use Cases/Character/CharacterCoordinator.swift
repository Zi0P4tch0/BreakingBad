import Resolver
import UIKit

// MARK: - Protocol

protocol CharacterCoordinatorType {
    func start(on navigationController: UINavigationController, with character: Character)
}

// MARK: - Concrete Class

final class CharacterCoordinator {

    @Injected
    private var reviewCoordinator: ReviewCoordinatorType

    private weak var navigationController: UINavigationController?

}

// MARK: - CharacterCoordinatorType

extension CharacterCoordinator: CharacterCoordinatorType {

    func start(on navigationController: UINavigationController, with character: Character) {
        let viewModel = CharacterViewModel(character: character)
        let viewController = CharacterViewController()
        viewController.delegate = self
        viewController.viewModel = viewModel
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }

}

// MARK: - CharacterViewControllerDelegate

extension CharacterCoordinator: CharacterViewControllerDelegate {

    func didTapReview(for character: Character) {
        guard let navigationController = navigationController else { return }
        reviewCoordinator.start(on: navigationController, for: character)
    }

}
