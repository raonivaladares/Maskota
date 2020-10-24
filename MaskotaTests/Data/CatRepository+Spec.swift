import Quick
import Nimble
import Combine

@testable import Maskota

final class CatRepositorySpec: QuickSpec {
    override func spec() {
        var localDataSourceMock: CatRealmDataSourceMock!
        var systemUnderTest: CatRepository!

        beforeEach {
            localDataSourceMock = CatRealmDataSourceMock()
            systemUnderTest = CatRepositoryImp(localDataSource: localDataSourceMock)
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

        describe("#publisher") {
            var receiveValueInvovations: Int!
            var failureCompletionInvovation: Int!
            var finishedCompletionInvovation: Int!

            var subscriptions: Set<AnyCancellable>!

            beforeEach {
                receiveValueInvovations = 0
                failureCompletionInvovation = 0
                finishedCompletionInvovation = 0

                subscriptions = Set<AnyCancellable>()

                systemUnderTest.publisher
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .failure:
                            failureCompletionInvovation += 1
                        case .finished:
                            finishedCompletionInvovation += 1
                        }
                    }, receiveValue: { models in
                        receiveValueInvovations += 1
                    })
                    .store(in: &subscriptions)
            }

            it("receive values only once") {
                expect(receiveValueInvovations).to(equal(1))
            }

            it("does not receive a failure event") {
                expect(failureCompletionInvovation).to(equal(0))
            }

            it("receive a complete event") {
                expect(finishedCompletionInvovation).to(equal(1))
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
