import Foundation
import RealmSwift

extension Decodable {
    public func cache() {
        let mirror = Mirror(reflecting: self)
        
        mirror.children.forEach {
            if let cacheables = $0.value as? [Object] {
                cacheables.forEach { $0.cache() }
                
            }
            else if let cacheable = $0.value as? Object {
                cacheable.cache()
            }
            else if let decodable = $0.value as? Decodable {
                decodable.cache()
            }
        }
    }
}
