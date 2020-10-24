@testable import Maskota

extension FeedTimeWire: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localID == rhs.localID &&
        lhs.hours == rhs.hours &&
        lhs.minutes == rhs.minutes
    }
}
