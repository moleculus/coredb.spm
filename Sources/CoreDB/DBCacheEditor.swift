import Foundation
import RealmSwift

public struct DBCacheEditor<DBObject: RealmSwift.Object & Identifiable> {
    
    // Properties.
    
    private let realm: Realm
    
    // MARK: - Initialization.
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    // MARK: - Public Methods.
    
    public func remove(matching predicate: NSPredicate?) {
        let cached: [DBObject] = DBCacheLoader<DBObject>(realm: realm).with(predicate: predicate)
        
        try! realm.write {
            realm.delete(cached)
        }
    }
    
    public func cache(_ object: DBObject, changing handler: (DBObject) -> Void) {
        try! realm.write() {
            handler(object)
            realm.add(object, update: .all)
        }
    }
        
}
