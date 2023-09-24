import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        
        return "(\(argument), \(literal: argument.description))"
    }
}

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
        let getter = AccessorDeclSyntax(stringLiteral: """
        get {
            self[keyPath: \(keyPath)]
        }
        """)
        let setter = AccessorDeclSyntax(stringLiteral: """
        set {
            self[keyPath: \(keyPath)] = newValue
        }
        """)
        return [getter, setter]
    }
}

@main
struct PropertyAccessorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        PropertyAccessorMacro.self
    ]
}
