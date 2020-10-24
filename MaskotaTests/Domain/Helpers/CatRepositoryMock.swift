import Combine

@testable import Maskota

final class CatRepositoryMock: CatRepository {
    var catsPublisher = CurrentValueSubject<[CatWire], Never>([])

    var publisherInvocations = 0
    var saveInvocations = 0
    var deleteInvocations = 0

    var publisher: AnyPublisher<[CatWire], Never> {
        publisherInvocations += 1

        return catsPublisher
            .eraseToAnyPublisher()
    }

    func save(catWire: CatWire) {
        saveInvocations += 1
    }

    func delete(catWire: CatWire) {
        deleteInvocations += 1
    }
}
