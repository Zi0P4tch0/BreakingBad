# Brain In Hand Technical Task

The following code has been developed using **Xcode 12.5** - it may not work on previous versions of the IDE.

## Dependencies

Ruby version (`.ruby-version`) and gemset (`.ruby-gemset`) files should be picked up by most of Ruby managers.

To install the Ruby dependencies, please run:

```bundle install```

Once the Ruby dependencies are in, please run:

```pod install```

...to update Cocoapods dependencies.

Dependencies used:
- RxSwift / RxCocoa 6.x.x
- Kingfisher (image downloading / caching)
- Realm (persistence) + Rx extensions
- R.swift (statically generates resources mapping, like Android Studio does)
- Cartography (AutoLayout DSL)
- Eureka (form builder)

## Architecture

MVVM-C (MVVM + Coordinators)
