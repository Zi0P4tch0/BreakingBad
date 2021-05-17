@testable import BreakingBad
import XCTest
import RxTest

class CharacterViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var imageService: FakeImageService!
    var quoteRepository: FakeQuoteRepository!
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

        scheduler = TestScheduler(initialClock: 0)
        imageService = FakeImageService(scheduler: scheduler)
        quoteRepository = FakeQuoteRepository(scheduler: scheduler)
        sut = CharacterViewModel(character: .fake(), imageService: imageService, quoteRepository: quoteRepository)
        disposeBag = DisposeBag()
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

        let image = Images.like.normal()
        imageService.fetchImageResult = image

        // Image is fetched when the character view model is allocated
        sut = CharacterViewModel(character: .fake(), imageService: imageService, quoteRepository: quoteRepository)

        let imageObserver = scheduler.createObserver(UIImage?.self)

        sut.outputs.image
            .drive(imageObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(imageObserver.events, [
            .next(20, image),
            .completed(20)
        ])

    }

    func testOutsputsNotNilBirthdayDate() {

        let dateObserver = scheduler.createObserver(NSAttributedString.self)

        let date = Date()

        sut = CharacterViewModel(character: .fake(birthday: date), imageService: imageService, quoteRepository: quoteRepository)

        sut.outputs.birthday
            .drive(dateObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        let expected = CharacterViewModel.attributedString(boldPart: R.string.localizable.characterBirthday(),
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

        let expected = CharacterViewModel.attributedString(boldPart: Strings.characterBirthday(),
                                                           normalPart: Strings.characterBirthdayUnknown())

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

        let expected = CharacterViewModel.attributedString(boldPart: R.string.localizable.characterOccupation(),
                                                           normalPart: Character.fake().occupation.joined(separator: "\n"))

        XCTAssertEqual(occupationObserver.events, [
            .next(0, expected),
            .completed(0)
        ])

    }

}
