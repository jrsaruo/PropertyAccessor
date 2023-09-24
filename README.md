# PropertyAccessor

An accessor macro that adds the getter and the setter to the property.

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 15+
- Swift 5.9+

## Usage

```swift
final class CustomView: UIView {
    private let titleLabel = UILabel()

    @Accessor(to: \Self.titleLabel.text)
    var title: String?

    /*
    Expanded to:
    
    var title: String? {
        get {
            self[keyPath: \Self.titleLabel.text]
        }
        set {
            self[keyPath: \Self.titleLabel.text] = newValue
        }
    }
    */
}
```

## Using PropertyAccessor in your project

To use the `PropertyAccessor` library in a SwiftPM project, add the following line to the dependencies in your `Package.swift` file:

```swift
.package(url: "https://github.com/jrsaruo/PropertyAccessor", from: "1.0.0"),
```

and add `PropertyAccessor` as a dependency for your target:

```swift
.target(name: "<target>", dependencies: [
    .product(name: "PropertyAccessor", package: "PropertyAccessor"),
    // other dependencies
]),
```

Finally, add `import PropertyAccessor` in your source code.

> [!NOTE]
> You may see an alert that says “'PropertyAccessorMacros' must be enabled before it can be used. Enable it now?” so you will have to trust and enable it.