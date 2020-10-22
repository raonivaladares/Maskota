import Quick
import Nimble

@testable import Maskota

final class CatSpec: QuickSpec {
    override func spec() {
        describe("#init(wire:)") {
            let catWire = CatWire.mock
            let systemUnderTest = Cat(wire: catWire)

            it("initializes with expected value") {
                expect(systemUnderTest.localID).to(equal(catWire.localID))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.name).to(equal(catWire.name))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.feedTimes.count).to(equal(catWire.feedTimes.count))
            }

            it("initializes with expected value") {
                let feedTime = FeedTime(feedTimeWire: catWire.feedTimes.first!)

                expect(systemUnderTest.feedTimes.first).to(equal(feedTime))
            }
        }
    }
}
