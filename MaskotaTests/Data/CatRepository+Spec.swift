import Quick
import Nimble

@testable import Maskota

final class CatRepositorySpec: QuickSpec {
    override func spec() {
        var localDataSourceMock: CatRealmDataSourceMock!
        var systemUnderTest: CatRepository!

        beforeEach {
            localDataSourceMock = CatRealmDataSourceMock()
            systemUnderTest = CatRepository(localDataSource: localDataSourceMock)
        }

        describe("#init") {
            it("calls retriaveAll only once") {
                expect(localDataSourceMock.retriaveAllInvocations).to(equal(1))
            }

            it("does not call save") {
                expect(localDataSourceMock.saveInvocations).to(equal(0))
            }

            it("does not call delete") {
                expect(localDataSourceMock.deleteInvocations).to(equal(0))
            }
        }

        describe("#save") {
            beforeEach {
                systemUnderTest.save(catWire: .mock)
            }

            it("calls retriaveAll once more after init") {
                expect(localDataSourceMock.retriaveAllInvocations).toEventually(equal(2))
            }

            it("calls save only once") {
                expect(localDataSourceMock.saveInvocations).to(equal(1))
            }

            it("does not call delete") {
                expect(localDataSourceMock.deleteInvocations).to(equal(0))
            }
        }

        describe("#delete") {
            beforeEach {
                systemUnderTest.delete(catWire: .mock)
            }

            it("calls retriaveAll once more after init") {
                expect(localDataSourceMock.retriaveAllInvocations).toEventually(equal(2))
            }

            it("does not call save") {
                expect(localDataSourceMock.saveInvocations).to(equal(0))
            }

            it("calls delete only once") {
                expect(localDataSourceMock.deleteInvocations).to(equal(1))
            }
        }
    }
}
