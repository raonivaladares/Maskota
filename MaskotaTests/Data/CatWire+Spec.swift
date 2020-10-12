import Quick
import Nimble

@testable import Maskota

final class CatWireSpec: QuickSpec {
    override func spec() {
        describe("#init(cat:)") {
            let cat = Cat.mock
            let systemUnderTest = CatWire(cat: cat)

            it("initializes with expected value") {
                expect(systemUnderTest.localID).to(equal(cat.localID))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.name).to(equal(cat.name))
            }

            it("initializes with expected value") {
                expect(systemUnderTest.feedTimes.count).to(equal(cat.feedTimes.count))
            }

            it("initializes with expected value") {
                let feedTime = FeedTimeWire(feedTime: cat.feedTimes.first!)

                expect(systemUnderTest.feedTimes.first).to(equal(feedTime))
            }
        }
    }
}

