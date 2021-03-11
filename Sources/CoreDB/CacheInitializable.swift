import Foundation
import RealmSwift

public protocol CacheInitializable: Identifiable {
    associatedtype DBObject: RealmSwift.Object & Identifiable
        
    var id: DBObject.ID { get }
    init(cached: DBObject) throws
}

public extension CacheInitializable {
    static func cached(id: DBObject.ID, in realm: Realm = .default) throws -> Self {
        let cached = try DBCacheLoader<DBObject>(in: realm).with(id: id)
        return try Self(cached: cached)
    }
    
    static func cached(matching predicate: NSPredicate, in realm: Realm = .default) throws -> Self {
        let cached = try DBCacheLoader<DBObject>(in: realm).with(predicate: predicate)
        return try Self(cached: cached)
    }
    
    static func allCached(matching predicate: NSPredicate? = nil, in realm: Realm = .default) -> [Self] {
        let cached = DBCacheLoader<DBObject>(in: realm).with(predicate: predicate)
        return cached.compactMap { try? Self(cached: $0) }
    }
    
    static func removeAll(in realm: Realm = .default) {
        DBCacheEditor<DBObject>(in: realm).remove(matching: nil)
    }
    
    static func remove(matching predicate: NSPredicate, in realm: Realm = .default) {
        DBCacheEditor<DBObject>(in: realm).remove(matching: predicate)
    }
}
