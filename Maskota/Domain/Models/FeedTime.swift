struct FeedTime {
    let localID: String
    let hours: Int
    let minutes: Int
}

extension FeedTime {
    init(feedTimeWire: FeedTimeWire) {
        localID = feedTimeWire.localID
        hours = feedTimeWire.hours
        minutes = feedTimeWire.minutes
    }
}
