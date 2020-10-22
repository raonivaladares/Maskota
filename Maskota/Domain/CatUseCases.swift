import Combine

protocol CatUseCase {
    var publisher: AnyPublisher<[Cat], Never> { get }
    func save(cat: Cat)
    func delete(cat: Cat)
}

final class CatUseCaseImp: CatUseCase {

    // MARK: - Private properties

    private let repository: CatRepository

    // MARK: - Internal properties

    var publisher: AnyPublisher<[Cat], Never> {
        repository
            .publisher
            .map { $0.map(Cat.init) }
            .eraseToAnyPublisher()
    }

    // MARK: - Inits

    init(repository: CatRepository) {
        self.repository = repository
    }

    // MARK: - Internal methods

    func save(cat: Cat) {
        repository.save(catWire: .init(model: cat))
    }

    func delete(cat: Cat) {
        repository.delete(catWire: .init(model: cat))
    }
}
