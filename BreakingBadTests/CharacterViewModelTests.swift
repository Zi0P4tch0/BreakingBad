@testable import BreakingBad
import XCTest
import RxTest
import RxSwift
import RealmSwift
import Resolver

class CharacterViewModelTests: XCTestCase {

    @LazyInjected
    private var scheduler: TestScheduler
    
    @LazyInjected
    private var imageService: FakeImageService

    @LazyInjected(name: .birthdayDateFormatter)
    private var birthdayDateFormatter: DateFormatter

    var sut: CharacterViewModelType!
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

        Resolver.main.register { FakeQuoteRepository() }
            .implements(QuoteRepositoryType.self)
            .scope(.cached)

        sut = CharacterViewModel(character: .fake())
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
            .next(0, Character.fake().name),
            .completed(0)
        ])

    }

    func testFetchesImage() {

        let imageObserver = scheduler.createObserver(UIImage?.self)

        sut.outputs.image
            .drive(imageObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssert(imageService.fetchImageCalled)

    }

    func testOutputsImageFetchedFromTheImageService() {

        let image = "like.normal".image()
        imageService.fetchImageResult = image

        // Image is fetched when the character view model is allocated
        sut = CharacterViewModel(character: .fake())

        let imageObserver = scheduler.createObserver(UIImage?.self)

        sut.outputs.image
            .drive(imageObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(imageObserver.events, [
            .next(0, nil),
            .next(20, image),
            .completed(20)
        ])

    }

    func testOutsputsNotNilBirthdayDate() {

        let dateObserver = scheduler.createObserver(NSAttributedString.self)

        let date = Date()

        sut = CharacterViewModel(character: .fake(birthday: date))

        sut.outputs.birthday
            .drive(dateObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        let expected = CharacterViewModel.attributedString(boldPart: "character.birthday".localized(),
                                                           normalPart: birthdayDateFormatter.string(from: date))

        XCTAssertEqual(dateObserver.events, [
            .next(0, expected),
            .completed(0)
        ])

    }

    func testOutsputsNilBirthdayDate() {

        let dateObserver = scheduler.createObserver(NSAttributedString.self)

        sut.outputs.birthday
            .drive(dateObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        let expected = CharacterViewModel.attributedString(boldPart: "character.birthday".localized(),
                                                           normalPart: "character.birthday.unknown".localized())

        XCTAssertEqual(dateObserver.events, [
            .next(0, expected),
            .completed(0)
        ])

    }

    func testOutputsOccupation() {

        let occupationObserver = scheduler.createObserver(NSAttributedString.self)

        sut.outputs.occupation
            .drive(occupationObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        let expected = CharacterViewModel.attributedString(boldPart: "character.occupation".localized(),
                                                           normalPart: Character.fake().occupation.joined(separator: "\n"))

        XCTAssertEqual(occupationObserver.events, [
            .next(0, expected),
            .completed(0)
        ])

    }

}
