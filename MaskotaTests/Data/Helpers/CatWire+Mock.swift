@testable import Maskota

extension CatWire {
    static let mock = CatWire(
        localID: "CatlocalID",
        name: "name",
        feedTimes: [
            .init(localID: "FeedTimelocalID", hours: 10, minutes: 20),
            .init(localID: "FeedTimelocalID2", hours: 15, minutes: 30)
        ]
    )
}
