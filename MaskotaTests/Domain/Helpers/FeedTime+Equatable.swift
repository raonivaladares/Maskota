@testable import Maskota

extension FeedTime: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localID == rhs.localID &&
            lhs.hours == rhs.hours &&
            lhs.minutes == rhs.minutes
    }
}
