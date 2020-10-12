import Foundation

struct FeedTimeWire {
    let localID: String
    let hours: Int
    let minutes: Int
}

extension FeedTimeWire {
    init(feedTime: FeedTime) {
        localID = feedTime.localID
        hours = feedTime.hours
        minutes = feedTime.minutes
    }
}
