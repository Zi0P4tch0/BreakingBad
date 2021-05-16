import SwiftUI

protocol ReviewCoordinatorType {
    func start(on navigationController: UINavigationController, for character: Character)
}

final class ReviewCoordinator {

    private let reviewRepository: ReviewRepositoryType

    init(reviewRepository: ReviewRepositoryType) {
        self.reviewRepository = reviewRepository
    }

}

extension ReviewCoordinator: ReviewCoordinatorType {

    func start(on navigationController: UINavigationController, for character: Character) {
        let viewController = ReviewViewController()
        let viewModel = ReviewViewModel(character: character, reviewRepository: reviewRepository)
        viewController.viewModel = viewModel
        let innerNavigationController = UINavigationController(rootViewController: viewController)
        navigationController.present(innerNavigationController, animated: true, completion: nil)
    }

}
