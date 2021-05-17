import Foundation

// MARK: - Protocol

protocol CoordinatorFactoryType {
    func makeApp() -> AppCoordinatorType
}

// MARK: - Implementation

final class CoordinatorFactory {

    private let repository: RepositoryType
    private let imageService: ImageServiceType

    init() {
        repository = Repository()
        imageService = ImageService()
    }

}

// MARK: - CoordinatorFactory + CoordinatorFactoryType

extension CoordinatorFactory: CoordinatorFactoryType {

    func makeApp() -> AppCoordinatorType {
        AppCoordinator(charactersCoordinator: makeCharacters())
    }

    func makeCharacters() -> CharactersCoordinatorType {
        CharactersCoordinator(charactersRepository: repository,
                              characterCoordinator: makeCharacter())
    }

    func makeCharacter() -> CharacterCoordinatorType {
        CharacterCoordinator(imageService: imageService,
                             quoteRepository: repository,
                             reviewCoordinator: makeReview())
    }

    func makeReview() -> ReviewCoordinatorType {
        ReviewCoordinator(reviewRepository: repository)
    }
}
