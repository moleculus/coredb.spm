import Foundation
import RealmSwift

public protocol CacheInitializable {
    associatedtype DBObject: RealmSwift.Object
    
    var id: String { get }
    init(cached: DBObject) throws
}

public extension CacheInitializable {
    static func with(id: Int) throws -> Self {
        let cached = try DBCacheLoader<DBObject>().with(id: id)
        return try Self(cached: cached)
    }
    
    static func with(predicate: NSPredicate) throws -> Self {
        let cached = try DBCacheLoader<DBObject>().with(predicate: predicate)
        return try Self(cached: cached)
    }
    
    static func all(matching predicate: NSPredicate? = nil) -> [Self] {
        let cached = DBCacheLoader<DBObject>().with(predicate: predicate)
        return cached.compactMap { try? Self(cached: $0) }
    }
    
    static func removeAll() {
        DBCacheEditor<DBObject>().remove(matching: nil)
    }
    
    static func remove(matching predicate: NSPredicate) {
        DBCacheEditor<DBObject>().remove(matching: predicate)
    }
}
