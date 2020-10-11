import RealmSwift

public extension Realm {
    static var `default`: Realm {
        return try! Realm()
    }
}
