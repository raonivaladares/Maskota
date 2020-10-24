struct FeedTime {
    let localID: String
    let hours: Int
    let minutes: Int
}

extension FeedTime {
    init(wire: FeedTimeWire) {
        localID = wire.localID
        hours = wire.hours
        minutes = wire.minutes
    }
}
