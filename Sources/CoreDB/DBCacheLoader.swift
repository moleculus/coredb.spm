import Foundation
import RealmSwift

public struct DBCacheLoader<DBObject: RealmSwift.Object> {
    
    // Properties.
    
    private let realm: Realm
    
    // MARK: - Initialization.
    
    public init(realm: Realm = .default) {
        self.realm = realm
    }
    
    // MARK: - Public Methods.
    
    func with(predicate: NSPredicate?) -> [DBObject] {
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
    
    func with(id: String) throws -> DBObject {
        guard let object = realm.object(ofType: DBObject.self, forPrimaryKey: id) else {
            throw DatabaseError.failedToFindObjectById(type: DBObject.self, id: id)
        }
        
        return object
    }
    
    func with(predicate: NSPredicate) throws -> DBObject {
        guard let object = realm.objects(DBObject.self).filter(predicate).first else {
            throw DatabaseError.failedToFindObjectWithPredicate(type: DBObject.self, predicate: predicate)
        }

        return object
    }
    
}
