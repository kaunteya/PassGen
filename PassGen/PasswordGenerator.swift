import Foundation

struct PasswordGenerator {
    static let lowercase = "abcdefghijklmnopqrstuvwxyz"
    static let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let numbers = "0123456789"
    static let symbols = ")(*&^%$#@!~`[]{}:;'<>?,."

    func callAsFunction(upperCase: Bool, lowerCase: Bool, numbers: Bool, symbols: Bool, length: Int) -> String {
        var str = ""
        if upperCase { str += Self.uppercase }
        if lowerCase { str += Self.lowercase }
        if numbers { str += Self.numbers }
        if symbols { str += Self.symbols }

        return String(str.shuffled().shuffled().shuffled().prefix(length))
    }
}
