import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `Accessor` macro attached to the property,
/// which adds the getter and the setter via the specified key path to the property.
///
///     @Accessor(to: \Self.foo.value)
///     var fooValue: Int
///
/// will expand to
///
///     var fooValue: Int {
///         get {
///             self[keyPath: \Self.foo.value]
///         }
///         set {
///             self[keyPath: \Self.foo.value] = newValue
///         }
///     }
public struct PropertyAccessorMacro: AccessorMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        guard let argument = node.arguments?.as(LabeledExprListSyntax.self)?.first else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        let keyPath = argument.expression
        return [
            """
            get {
                self[keyPath: \(keyPath)]
            }
            """,
            """
            set {
                self[keyPath: \(keyPath)] = newValue
            }
            """
        ]
    }
}

@main
struct PropertyAccessorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PropertyAccessorMacro.self
    ]
}
