//
//  CharactersCoordinator.swift
//  BreakingBad
//
//  Created by Matteo Pacini on 15/05/2021.
//

import UIKit

protocol CharactersCoordinatorType {
    func start(on window: UIWindow)
}

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

extension CharactersCoordinator: CharactersViewControllerDelegate {

    func didSelect(character: Character) {
        guard let navigationController = navigationController else { return }
        characterCoordinator.start(on: navigationController, with: character)
    }

}
