import Combine
import Foundation

final class CatRepository {

    // MARK: - Private properties

    private var catsPublisher = CurrentValueSubject<[CatWire], Never>([])
    private let localDataSource: CatRealmDataSource

    // MARK: - Internal properties

    var publisher: AnyPublisher<[CatWire], Never> {
        catsPublisher
            .share()
            .eraseToAnyPublisher()
    }

    // MARK: - Inits

    init(localDataSource: CatRealmDataSource) {
        self.localDataSource = localDataSource

        updatePublisher()
    }

    // MARK: - Internal Methods

    func save(catWire: CatWire) {
        localDataSource.save(models: [catWire])

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updatePublisher()
        }
    }

    func delete(catWire: CatWire) {
        localDataSource.delete(modelWire: catWire)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.updatePublisher()
        }
    }

    // MARK: - Private Methods

    private func updatePublisher() {
        catsPublisher.send(
            localDataSource.retriaveAll()
        )
    }
}
