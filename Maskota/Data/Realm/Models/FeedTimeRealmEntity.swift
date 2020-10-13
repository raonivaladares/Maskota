import RealmSwift
import Foundation

class FeedTimeRealmEntity: Object {
    @objc dynamic var id = ""
    @objc dynamic var hours = 0
    @objc dynamic var minutes = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension FeedTimeRealmEntity {
    convenience init(feedTimeWire: FeedTimeWire) {
        self.init()

        id = feedTimeWire.localID
        hours = feedTimeWire.hours
        minutes = feedTimeWire.minutes
    }
}
