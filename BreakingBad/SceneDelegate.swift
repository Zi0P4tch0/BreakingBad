import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var coordinatorFactory: CoordinatorFactoryType!
    var appCoordinator: AppCoordinatorType!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        #if DEBUG
        // Don't run the whole app if unit tests are running
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }
        #endif

        window = UIWindow(windowScene: windowScene)

        coordinatorFactory = CoordinatorFactory()
        appCoordinator = coordinatorFactory.makeApp()

        // swiftlint:disable:next force_unwrapping
        appCoordinator.start(on: window!)

    }

}
