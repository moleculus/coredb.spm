import Foundation
import RealmSwift

public extension Object {
    func cache(in realm: Realm) {
        try! realm.write() {
            realm.add(self, update: .all)
        }
    }
}
