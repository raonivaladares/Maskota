import Combine

protocol CatUseCases {
    var publisher: AnyPublisher<[Cat], Never> { get }
    func save(cat: Cat)
    func delete(cat: Cat)
}

final class CatUseCasesImp {

    // MARK: - Private properties

    private let repository: CatRepository

    // MARK: - Inits

    init(repository: CatRepository) {
        self.repository = repository
    }
}

// MARK: - CatUseCase

extension CatUseCasesImp: CatUseCases {
    var publisher: AnyPublisher<[Cat], Never> {
        repository
            .publisher
            .map { $0.map(Cat.init) }
            .eraseToAnyPublisher()
    }

    func save(cat: Cat) {
        repository.save(catWire: .init(model: cat))
    }

    func delete(cat: Cat) {
        repository.delete(catWire: .init(model: cat))
    }
}
