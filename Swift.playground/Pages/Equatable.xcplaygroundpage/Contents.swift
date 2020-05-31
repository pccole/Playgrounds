/*:
 # Equatable
 */
// Complier generates the conformace requirement because string conforms to equatable
struct Email: Equatable {
    private (set) var address: String
    
    init?(_ raw: String) {
        guard raw.contains("@") else {
            return nil
        }
        address = raw
    }
}


// Complier will not auto-generate conformance because it may create a circular graph of objects
// creating an infinite loop of checking for equality
class User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.email == rhs.email
    }
    
    var id: Int?
    var name: String
    var email: Email
    
    init(id: Int?, name: String, email: Email) {
        self.id = id
        self.name = name
        self.email = email
    }
}
//: [Next](@next)
