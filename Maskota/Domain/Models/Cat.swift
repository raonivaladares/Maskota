struct Cat {
    let localID: String
    let name: String
    let feedTimes: [FeedTime]
}

extension Cat {
    init(catWire: CatWire) {
        localID = catWire.localID
        name = catWire.name
        feedTimes = catWire.feedTimes.map(FeedTime.init)
    }
}
