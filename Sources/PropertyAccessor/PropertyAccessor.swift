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
