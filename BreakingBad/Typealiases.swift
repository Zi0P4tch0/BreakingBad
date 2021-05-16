import Foundation
import RealmSwift
import RxCocoa
import RxSwift

// The purpose of this file is to avoid repeating imports
// across the codebase.

// MARK: - Realm
typealias Realm = RealmSwift.Realm
typealias List = RealmSwift.List
typealias Object = RealmSwift.Object

// MARK: - RxSwift / RxCocoa
typealias Single = RxSwift.Single
typealias Disposables = RxSwift.Disposables
typealias Driver = RxCocoa.Driver
typealias PublishSubject = RxSwift.PublishSubject
typealias DisposeBag = RxSwift.DisposeBag
typealias Observable = RxSwift.Observable
