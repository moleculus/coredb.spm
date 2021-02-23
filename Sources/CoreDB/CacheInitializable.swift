import Foundation
import RealmSwift

public protocol CacheInitializable: Identifiable {
    associatedtype DBObject: RealmSwift.Object & Identifiable
        
    var id: DBObject.ID { get }
    init(cached: DBObject) throws
}

public extension CacheInitializable {
    static func cached(id: DBObject.ID) throws -> Self {
        let cached = try DBCacheLoader<DBObject>().with(id: id)
        return try Self(cached: cached)
    }
    
    static func cached(matching predicate: NSPredicate) throws -> Self {
        let cached = try DBCacheLoader<DBObject>().with(predicate: predicate)
        return try Self(cached: cached)
    }
    
    static func allCached(matching predicate: NSPredicate? = nil) -> [Self] {
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
