import Foundation
import Resolver
import RxSwift

extension Resolver.Name {
    static let birthdayDateFormatter = Resolver.Name("birthdayDateFormatter")
}

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        // Register date formatters only in case we're testing
        guard NSClassFromString("XCTest") == nil else {
            registerDateFormatters()
            return
        }
        registerAppServices()
        registerRepository()
        registerCoordinators()
        registerDateFormatters()
    }

    private static func registerAppServices() {

        Resolver.main.register { ImageService() }
            .implements(ImageServiceType.self)
            .scope(.application)

    }

    private static func registerRepository() {

        Resolver.main.register { Repository() }
            .implements(RepositoryType.self)
            .implements(CharacterRepositoryType.self)
            .implements(QuoteRepositoryType.self)
            .implements(ReviewRepositoryType.self)
            .scope(.application)

    }

    private static func registerCoordinators() {

        // There can be only one ™️
        Resolver.main.register { AppCoordinator() }
            .implements(AppCoordinatorType.self)
            .scope(.application)

        Resolver.main.register { CharactersCoordinator() }
            .implements(CharactersCoordinatorType.self)

        Resolver.main.register { CharacterCoordinator() }
            .implements(CharacterCoordinatorType.self)

        Resolver.main.register { ReviewCoordinator() }
            .implements(ReviewCoordinatorType.self)

    }

    private static func registerDateFormatters() {

        Resolver.main.register(name: .birthdayDateFormatter) { () -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter
        }.scope(.application)

    }

}

func resolve<Service>(_ name: Resolver.Name? = nil) -> Service {
    Resolver.resolve(Service.self, name: name, args: nil)
}
