@testable import Maskota

extension Cat {
    static let mock = Cat(
        localID: "CatlocalID",
        name: "name",
        feedTimes: [
            .init(localID: "FeedTimelocalID", hours: 10, minutes: 20),
            .init(localID: "FeedTimelocalID2", hours: 15, minutes: 30)
        ]
    )
}
