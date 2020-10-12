import Foundation

struct CatWire {
    let localID: String
    let name: String
    let feedTimes: [FeedTimeWire]
}

extension CatWire {
    init(cat: Cat) {
        localID = cat.localID
        name = cat.name
        feedTimes = cat.feedTimes.map(FeedTimeWire.init)
    }
}
