import RealmSwift
import Foundation

class CatRealmEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    let feedTimes = List<FeedTimeRealmEntity>()


    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CatRealmEntity {
    convenience init(wire: CatWire) {
        self.init()

        id = wire.localID
        name = wire.name

        wire.feedTimes.forEach { feedTimes.append(.init(feedTimeWire: $0)) }
    }
}
