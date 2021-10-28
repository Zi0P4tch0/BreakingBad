import Resolver
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @LazyInjected
    private var appCoordinator: AppCoordinatorType

    // MARK: UIWindowSceneDelegate

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)
        // swiftlint:disable:next force_unwrapping
        window!.backgroundColor = .white

        #if DEBUG
        // Don't run the whole app if unit tests are running
        guard NSClassFromString("XCTest") == nil else { return }
        #endif

        // swiftlint:disable:next force_unwrapping
        appCoordinator.start(on: window!)

    }

}
