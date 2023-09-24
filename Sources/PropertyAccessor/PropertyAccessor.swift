// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "PropertyAccessorMacros", type: "StringifyMacro")

/// A macro that adds the getter and the setter via the specified key path to the property.
///
/// For example,
///
///     @Accessor(to: \Self.foo.value)
///     var fooValue: Int
///
/// produces
///
///     var fooValue: Int {
///         get {
///             self[keyPath: \Self.foo.value]
///         }
///         set {
///             self[keyPath: \Self.foo.value] = newValue
///         }
///     }
///
/// You have to specify the key path where `Root` is `Self`.
@attached(accessor)
public macro Accessor<Root, Value>(
    to keyPath: KeyPath<Root, Value>
) = #externalMacro(module: "PropertyAccessorMacros", type: "PropertyAccessorMacro")
