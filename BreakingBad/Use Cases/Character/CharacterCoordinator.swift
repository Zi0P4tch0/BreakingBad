import UIKit

// MARK: - Protocol

protocol CharacterCoordinatorType {
    func start(on navigationController: UINavigationController, with character: Character)
}

// MARK: - Implementation

final class CharacterCoordinator {

    private let imageService: ImageServiceType
    private let quoteRepository: QuoteRepositoryType
    private let reviewCoordinator: ReviewCoordinatorType

    private weak var navigationController: UINavigationController?

    init(imageService: ImageServiceType,
         quoteRepository: QuoteRepositoryType,
         reviewCoordinator: ReviewCoordinatorType) {
        self.imageService = imageService
        self.quoteRepository = quoteRepository
        self.reviewCoordinator = reviewCoordinator
    }

}

// MARK: - CharacterCoordinator + CharacterCoordinatorType

extension CharacterCoordinator: CharacterCoordinatorType {

    func start(on navigationController: UINavigationController, with character: Character) {
        let viewModel = CharacterViewModel(character: character,
                                           imageService: imageService,
                                           quoteRepository: quoteRepository)
        let viewController = CharacterViewController()
        viewController.delegate = self
        viewController.viewModel = viewModel
        self.navigationController = navigationController
        navigationController.pushViewController(viewController, animated: true)
    }

}

// MARK: - CharacterCoordinator + CharacterViewControllerDelegate

extension CharacterCoordinator: CharacterViewControllerDelegate {

    func didTapReview(for character: Character) {
        guard let navigationController = navigationController else { return }
        reviewCoordinator.start(on: navigationController, for: character)
    }

}
