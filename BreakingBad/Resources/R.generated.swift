//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    /// This `R.image.like` struct is generated, and contains static references to 2 images.
    struct like {
      /// Image `Highlighted`.
      static let highlighted = Rswift.ImageResource(bundle: R.hostingBundle, name: "Like/Highlighted")
      /// Image `Normal`.
      static let normal = Rswift.ImageResource(bundle: R.hostingBundle, name: "Like/Normal")

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Highlighted", bundle: ..., traitCollection: ...)`
      static func highlighted(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.like.highlighted, compatibleWith: traitCollection)
      }
      #endif

      #if os(iOS) || os(tvOS)
      /// `UIImage(named: "Normal", bundle: ..., traitCollection: ...)`
      static func normal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
        return UIKit.UIImage(resource: R.image.like.normal, compatibleWith: traitCollection)
      }
      #endif

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 21 localization keys.
    struct localizable {
      /// Value: Birthday: 
      static let characterBirthday = Rswift.StringResource(key: "character.birthday", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Characters
      static let charactersTitle = Rswift.StringResource(key: "characters.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Error
      static let genericError = Rswift.StringResource(key: "generic.error", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Nickname: 
      static let characterNickname = Rswift.StringResource(key: "character.nickname", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: OK
      static let genericOk = Rswift.StringResource(key: "generic.ok", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Occupation: 
      static let characterOccupation = Rswift.StringResource(key: "character.occupation", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Please fill all the fields
      static let reviewErrorMissingFields = Rswift.StringResource(key: "review.error.missingFields", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Portrayed by: 
      static let characterPortrayedBy = Rswift.StringResource(key: "character.portrayedBy", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Rating
      static let reviewRating = Rswift.StringResource(key: "review.rating", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Review
      static let review = Rswift.StringResource(key: "review", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Seasons: 
      static let characterSeasons = Rswift.StringResource(key: "character.seasons", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Status: 
      static let characterStatus = Rswift.StringResource(key: "character.status", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Submit
      static let reviewSubmit = Rswift.StringResource(key: "review.submit", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: There are no characters to display.
      static let charactersEmpty = Rswift.StringResource(key: "characters.empty", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: There are no quotes for this character.
      static let characterNoQuotes = Rswift.StringResource(key: "character.noQuotes", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Unknown
      static let characterBirthdayUnknown = Rswift.StringResource(key: "character.birthday.unknown", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Unknown
      static let genericUnknown = Rswift.StringResource(key: "generic.unknown", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Watched date
      static let reviewWatchedDate = Rswift.StringResource(key: "review.watchedDate", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Write a review
      static let reviewTitle = Rswift.StringResource(key: "review.title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Write your review here
      static let reviewPlaceholder = Rswift.StringResource(key: "review.placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Your name
      static let reviewYourName = Rswift.StringResource(key: "review.yourName", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Birthday: 
      static func characterBirthday(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.birthday", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.birthday"
        }

        return NSLocalizedString("character.birthday", bundle: bundle, comment: "")
      }

      /// Value: Characters
      static func charactersTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("characters.title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "characters.title"
        }

        return NSLocalizedString("characters.title", bundle: bundle, comment: "")
      }

      /// Value: Error
      static func genericError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("generic.error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "generic.error"
        }

        return NSLocalizedString("generic.error", bundle: bundle, comment: "")
      }

      /// Value: Nickname: 
      static func characterNickname(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.nickname", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.nickname"
        }

        return NSLocalizedString("character.nickname", bundle: bundle, comment: "")
      }

      /// Value: OK
      static func genericOk(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("generic.ok", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "generic.ok"
        }

        return NSLocalizedString("generic.ok", bundle: bundle, comment: "")
      }

      /// Value: Occupation: 
      static func characterOccupation(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.occupation", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.occupation"
        }

        return NSLocalizedString("character.occupation", bundle: bundle, comment: "")
      }

      /// Value: Please fill all the fields
      static func reviewErrorMissingFields(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.error.missingFields", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.error.missingFields"
        }

        return NSLocalizedString("review.error.missingFields", bundle: bundle, comment: "")
      }

      /// Value: Portrayed by: 
      static func characterPortrayedBy(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.portrayedBy", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.portrayedBy"
        }

        return NSLocalizedString("character.portrayedBy", bundle: bundle, comment: "")
      }

      /// Value: Rating
      static func reviewRating(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.rating", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.rating"
        }

        return NSLocalizedString("review.rating", bundle: bundle, comment: "")
      }

      /// Value: Review
      static func review(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review"
        }

        return NSLocalizedString("review", bundle: bundle, comment: "")
      }

      /// Value: Seasons: 
      static func characterSeasons(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.seasons", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.seasons"
        }

        return NSLocalizedString("character.seasons", bundle: bundle, comment: "")
      }

      /// Value: Status: 
      static func characterStatus(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.status", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.status"
        }

        return NSLocalizedString("character.status", bundle: bundle, comment: "")
      }

      /// Value: Submit
      static func reviewSubmit(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.submit", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.submit"
        }

        return NSLocalizedString("review.submit", bundle: bundle, comment: "")
      }

      /// Value: There are no characters to display.
      static func charactersEmpty(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("characters.empty", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "characters.empty"
        }

        return NSLocalizedString("characters.empty", bundle: bundle, comment: "")
      }

      /// Value: There are no quotes for this character.
      static func characterNoQuotes(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.noQuotes", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.noQuotes"
        }

        return NSLocalizedString("character.noQuotes", bundle: bundle, comment: "")
      }

      /// Value: Unknown
      static func characterBirthdayUnknown(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("character.birthday.unknown", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "character.birthday.unknown"
        }

        return NSLocalizedString("character.birthday.unknown", bundle: bundle, comment: "")
      }

      /// Value: Unknown
      static func genericUnknown(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("generic.unknown", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "generic.unknown"
        }

        return NSLocalizedString("generic.unknown", bundle: bundle, comment: "")
      }

      /// Value: Watched date
      static func reviewWatchedDate(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.watchedDate", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.watchedDate"
        }

        return NSLocalizedString("review.watchedDate", bundle: bundle, comment: "")
      }

      /// Value: Write a review
      static func reviewTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.title"
        }

        return NSLocalizedString("review.title", bundle: bundle, comment: "")
      }

      /// Value: Write your review here
      static func reviewPlaceholder(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.placeholder", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.placeholder"
        }

        return NSLocalizedString("review.placeholder", bundle: bundle, comment: "")
      }

      /// Value: Your name
      static func reviewYourName(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("review.yourName", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "review.yourName"
        }

        return NSLocalizedString("review.yourName", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}