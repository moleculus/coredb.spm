import Foundation
import RealmSwift

public struct DBCacheEditor<DBObject: RealmSwift.Object> {
    
    // Properties.
    
    private let realm: Realm
    
    // MARK: - Initialization.
    
    public init(realm: Realm = .default) {
        self.realm = realm
    }
    
    // MARK: - Public Methods.
    
    public func remove(matching predicate: NSPredicate?) {
        let cached: [DBObject] = DBCacheLoader<DBObject>(realm: realm).with(predicate: predicate)
        
        try! realm.write {
            realm.delete(cached)
        }
    }
}
