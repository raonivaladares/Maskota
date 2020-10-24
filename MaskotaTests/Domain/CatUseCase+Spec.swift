import Quick
import Nimble

@testable import Maskota

final class CatUseCasesSpec: QuickSpec {
    override func spec() {
        var repositoryMock: CatRepositoryMock!
        var systemUnderTest:  CatUseCaseImp!

        beforeEach {
            repositoryMock = CatRepositoryMock()
            systemUnderTest = CatUseCaseImp(repository: repositoryMock)
        }

        describe("#init") {
            it("does not use publisher from repository") {
                expect(repositoryMock.publisherInvocations).to(equal(0))
            }

            it("does not call repository to save") {
                expect(repositoryMock.saveInvocations).to(equal(0))
            }

            it("does not call repository to delete") {
                expect(repositoryMock.deleteInvocations).to(equal(0))
            }
        }

        describe("#publisher") {
            let catsWire: [CatWire] = [.mock, .mock]
            var transformationResult: [Cat]!

            beforeEach {
                repositoryMock.catsPublisher.send(catsWire)
                _ = systemUnderTest.publisher.sink { transformationResult = $0 }
            }

            it("converts catsWire array to cats array") {
                expect(transformationResult.count).to(equal(catsWire.count))
            }

            it("converts content of catsWire to cats") {
                let expectedValue = Cat(wire: catsWire.first!)

                expect(transformationResult.first).to(equal(expectedValue))
            }
        }

        describe("#save") {
            beforeEach {
                systemUnderTest.save(cat: .mock)
            }

            it("does not use publisher from repository") {
                expect(repositoryMock.publisherInvocations).to(equal(0))
            }

            it("calls repository to save") {
                expect(repositoryMock.saveInvocations).to(equal(1))
            }

            it("does not call repository to delete") {
                expect(repositoryMock.deleteInvocations).to(equal(0))
            }
        }

        describe("#delete") {
            beforeEach {
                systemUnderTest.delete(cat: .mock)
            }

            it("does not use publisher from repository") {
                expect(repositoryMock.publisherInvocations).to(equal(0))
            }

            it("does not call repository to save") {
                expect(repositoryMock.saveInvocations).to(equal(0))
            }

            it("calls repository to delete") {
                expect(repositoryMock.deleteInvocations).to(equal(1))
            }
        }
    }
}
