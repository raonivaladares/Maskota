import Foundation

struct FeedTimeWire {
    let localID: String
    let hours: Int
    let minutes: Int
}

extension FeedTimeWire {
    init(model: FeedTime) {
        localID = model.localID
        hours = model.hours
        minutes = model.minutes
    }
}

extension FeedTimeWire {
    init(entity: FeedTimeRealmEntity) {
        localID = entity.id
        hours = entity.hours
        minutes = entity.minutes
    }
}
