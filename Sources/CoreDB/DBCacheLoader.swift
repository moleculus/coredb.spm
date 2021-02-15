import Foundation
import RealmSwift

public struct DBCacheLoader<DBObject: RealmSwift.Object & Identifiable> {
    
    // Properties.
    
    private let realm: Realm
    
    // MARK: - Initialization.
    
    public init(realm: Realm = .default) {
        self.realm = realm
    }
    
    // MARK: - Public Methods.
    
    public func with(predicate: NSPredicate?) -> [DBObject] {
        var objects: Results<DBObject> {
            if let predicate = predicate {
                return realm.objects(DBObject.self).filter(predicate)
            }
            else {
                return realm.objects(DBObject.self)
            }
        }
        
        return Array(objects)
    }
    
    public func with(id: DBObject.ID) throws -> DBObject {
        guard let object = realm.object(ofType: DBObject.self, forPrimaryKey: id) else {
            throw "Failed to find object of type \(DBObject.self) by ID"
        }
        
        return object
    }
    
    public func with(predicate: NSPredicate) throws -> DBObject {
        guard let object = realm.objects(DBObject.self).filter(predicate).first else {
            throw "Failed to find objects of type \(DBObject.self) with predicate \(predicate)"
        }

        return object
    }
    
}
