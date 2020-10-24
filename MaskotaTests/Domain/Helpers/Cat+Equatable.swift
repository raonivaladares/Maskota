@testable import Maskota

extension Cat: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.localID == rhs.localID &&
            lhs.name == rhs.name &&
            lhs.feedTimes == rhs.feedTimes
    }
}
