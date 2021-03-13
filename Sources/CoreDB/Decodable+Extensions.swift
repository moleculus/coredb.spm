import Foundation
import RealmSwift

extension Decodable {
    public func cache(in realm: Realm) {
        let mirror = Mirror(reflecting: self)
        
        mirror.children.forEach {
            if let cacheables = $0.value as? [Object] {
                cacheables.forEach { $0.cache(in: realm) }
                
            }
            else if let cacheable = $0.value as? Object {
                cacheable.cache(in: realm)
            }
            else if let decodable = $0.value as? Decodable {
                decodable.cache(in: realm)
            }
        }
    }
}
