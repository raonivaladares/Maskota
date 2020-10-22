struct Cat {
    let localID: String
    let name: String
    let feedTimes: [FeedTime]
}

extension Cat {
    init(wire: CatWire) {
        localID = wire.localID
        name = wire.name
        feedTimes = wire.feedTimes
            .map(FeedTime.init)
    }
}
