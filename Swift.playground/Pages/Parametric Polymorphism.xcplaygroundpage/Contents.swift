//: [Previous](@previous)
/*:
 # Parametric Polymorphism
 In programming languages and type theory, parametric polymorphism is a way to make a language more expressive,
 while still maintaining full static type-safety. Using parametric polymorphism, a function or a data type can be written
 generically so that it can handle values identically without depending on their type.
 */
import Foundation

struct Stack<Element> {
    private var storage: [Element] = []
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    var top: Element? {
        return storage.last
    }
    
    var isEmpty: Bool {
        return top == nil
    }
}

var stack = Stack<Int>()
stack.push(20)
stack.push(21)
stack.pop()

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

var ints: Stack = [1,2,3]
ints.pop()
ints.push(20)
ints.top
ints.isEmpty

//: [Next](@next)
