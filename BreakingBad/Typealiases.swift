import Foundation
import RealmSwift
import RxCocoa
import RxSwift

// The purpose of this file is to avoid repeating imports
// across the codebase.

// MARK: - R.swift
typealias Strings = R.string.localizable
typealias Images = R.image

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
typealias Binder = RxSwift.Binder
typealias Reactive = RxSwift.Reactive
typealias Event = RxSwift.Event
typealias RxTableViewDataSourceType = RxCocoa.RxTableViewDataSourceType
