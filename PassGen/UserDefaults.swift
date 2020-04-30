import Foundation
import Combine


extension UserDefaults {
    enum Key: String { case generateCountKey }

    static let generateCountKey = "generateCount"
    static let generateCountChanged = PassthroughSubject<Int, Never>()

    static var generateCount: Int {
        get {
            UserDefaults.standard.integer(forKey: generateCountKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: generateCountKey)
            generateCountChanged.send(newValue)
        }
    }
}
