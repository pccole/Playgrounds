//: [Previous](@previous)
/*:
 # Generic Constrains
 ### Inlinable
 Apply this attribute to a function, method, computed property, subscript, convenience initializer,
 or deinitializer declaration to expose that declaration’s implementation as part of the module’s
 public interface. The compiler is allowed to replace calls to an inlinable symbol with a copy of
 the symbol’s implementation at the call site.
 
 Inlinable code can interact with public symbols declared in any module, and it can interact with
 internal symbols declared in the same module that are marked with the usableFromInline attribute.
 Inlinable code can’t interact with private or fileprivate symbols.
 
 This attribute can’t be applied to declarations that are nested inside functions or to fileprivate
 or private declarations. Functions and closures that are defined inside an inlinable function are
 implicitly inlinable, even though they can’t be marked with this attribute.
 
 */
import Foundation

@inlinable func add<T>(_ a: T, _ b: T) -> T where T: Numeric {
    return a + b
}

add(3,4)

add(UInt(20), UInt(22))

//: [Next](@next)
