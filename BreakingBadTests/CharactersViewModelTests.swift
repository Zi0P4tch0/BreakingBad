@testable import BreakingBad
import XCTest
import Resolver
import RxTest
import RxSwift
import RealmSwift

class CharactersViewModelTests: XCTestCase {

    @LazyInjected
    var scheduler: TestScheduler

    @LazyInjected
    var charactersRepository: FakeCharactersRepository

    var sut: CharactersViewModelType!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {

        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: nil,
                                                                       inMemoryIdentifier: "unitTests",
                                                                       syncConfiguration: nil,
                                                                       encryptionKey: nil,
                                                                       readOnly: false,
                                                                       schemaVersion: 1,
                                                                       migrationBlock: nil,
                                                                       deleteRealmIfMigrationNeeded: false,
                                                                       shouldCompactOnLaunch: nil,
                                                                       objectTypes: nil)

        try Realm().write {
            try Realm().deleteAll()
        }

        Resolver.main.register { TestScheduler(initialClock: 0) }
            .scope(.cached)

        Resolver.main.register { FakeImageService() }
            .implements(ImageServiceType.self)
            .scope(.cached)

        Resolver.main.register { FakeCharactersRepository() }
            .implements(CharacterRepositoryType.self)
            .scope(.cached)

        sut = CharactersViewModel()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {

        ResolverScope.cached.reset()

    }

    func testOutputsTitle() {

        let titleObserver = scheduler.createObserver(String.self)

        sut.outputs.title
            .drive(titleObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(titleObserver.events, [
            .next(0, "characters.title".localized()),
            .completed(0)
        ])

    }

    func testFetchesCharactersOnViewDidLoadInput() {

        scheduler.start()

        sut.inputs.viewDidLoad.onNext(())

        XCTAssert(charactersRepository.allCharactersCalled)

    }

    func testStoresCharactersInRealmOnViewDidLoadInput() throws {

        charactersRepository.allCharactersResult = [.fake()]

        let characters = try Realm().objects(RealmCharacter.self)
        let characterObserver = scheduler.createObserver([Character].self)

        let exp = expectation(description: "Stores character in Realm on viewDidLoad input")

        Observable.array(from: characters)
            .map { $0.map { $0.toValue() } }
            .do(afterNext: { next in
                if !next.isEmpty {
                    exp.fulfill()
                }
            })
            .bind(to: characterObserver)
            .disposed(by: disposeBag)

        sut.inputs.viewDidLoad.onNext(())

        scheduler.start()

        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertEqual(characterObserver.events.count, 2)
            XCTAssertEqual(characterObserver.events, [.next(0, []), .next(20, [.fake()])])
        }
    }

    func testFetchesCharactersFromRealm() throws {

        try Realm().write {
            try Realm().add([Character.fake(), .fake(id: 1), .fake(id: 2)].map { RealmCharacter.init(character: $0) })
        }

        let characterObserver = scheduler.createObserver([Character].self)

        sut.outputs.characters
            .drive(characterObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(characterObserver.events.count, 1)
        XCTAssertEqual(characterObserver.events, [.next(0, [.fake(), .fake(id: 1), .fake(id: 2)])])

    }

    func testOutputsEmptyLabelText() {

        let emptyTextObserver = scheduler.createObserver(String.self)

        sut.outputs.emptyText
            .drive(emptyTextObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(emptyTextObserver.events, [
            .next(0, "characters.empty".localized()),
            .completed(0)
        ])

    }

    func testOutputsCorrectTableViewAlphaWithNoCharacters() {

        let alphaObserver = scheduler.createObserver(CGFloat.self)

        sut.outputs.tableViewAlpha
            .drive(alphaObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(alphaObserver.events, [
            .next(0, 0)
        ])

    }

    func testOutputsCorrectTableViewAlphaWithCharacters() throws {

        try Realm().write {
            try Realm().add([Character.fake(),
                             .fake(id: 1),
                             .fake(id: 2)].map { RealmCharacter.init(character: $0) })
        }

        let alphaObserver = scheduler.createObserver(CGFloat.self)

        sut.outputs.tableViewAlpha
            .drive(alphaObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(alphaObserver.events, [
            .next(0, 1)
        ])

    }

}
