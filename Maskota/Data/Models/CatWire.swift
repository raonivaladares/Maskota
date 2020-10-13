import Foundation

struct CatWire {
    let localID: String
    let name: String
    let feedTimes: [FeedTimeWire]
}

extension CatWire {
    init(model: Cat) {
        localID = model.localID
        name = model.name
        feedTimes = model.feedTimes
            .map(FeedTimeWire.init)
    }
}

extension CatWire {
    init(entity: CatRealmEntity) {
        localID = entity.id
        name = entity.name
        feedTimes = entity.feedTimes
            .map(FeedTimeWire.init)
    }
}
