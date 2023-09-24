import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(PropertyAccessorMacros)
import PropertyAccessorMacros

let testMacros: [String: Macro.Type] = [
    "Accessor": PropertyAccessorMacro.self
]
#endif

final class PropertyAccessorTests: XCTestCase {
    
    func testPropertyAccessorMacro() throws {
        #if canImport(PropertyAccessorMacros)
        assertMacroExpansion(
            #"""
            @Accessor(to: \Self.foo.value)
            private var fooValue: Int
            """#,
            expandedSource: #"""
            private var fooValue: Int {
                get {
                    self [keyPath: \Self.foo.value]
                }
                set {
                    self [keyPath: \Self.foo.value] = newValue
                }
            }
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
