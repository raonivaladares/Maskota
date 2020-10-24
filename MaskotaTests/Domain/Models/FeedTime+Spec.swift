import Quick
import Nimble

@testable import Maskota

final class FeedTimeSpec: QuickSpec {
    override func spec() {
        describe("#init(wire:)") {
            let wire = FeedTimeWire.mock
            let systemUnderTest = FeedTime(wire: wire)

            it("initializes with expected value") {
                expect(systemUnderTest.localID).to(equal(wire.localID))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.hours).to(equal(wire.hours))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.minutes).to(equal(wire.minutes))
            }
        }
    }
}
