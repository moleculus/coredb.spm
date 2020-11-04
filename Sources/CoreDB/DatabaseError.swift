import Foundation
import RealmSwift

enum DatabaseError: Error {
    case failedToFindObjectById (type: RealmSwift.Object.Type, id: Int)
    case failedToFindObjectWithPredicate (type: RealmSwift.Object.Type, predicate: NSPredicate)
}
