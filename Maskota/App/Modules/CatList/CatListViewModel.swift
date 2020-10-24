import SwiftUI
import Combine

final class CatListViewModel: ObservableObject {

    // MARK: - Private properties

    private var subscriptions = Set<AnyCancellable>()
    private var cats: [Cat] = []
    private let catUseCase: CatUseCases

    // MARK: - Internal properties

    @Published var catListRowViewModels: [CatListRowViewModel] = []

    // MARK: - Inits

    init(catUseCase: CatUseCases = AppContainer.shared.catUseCase) {
        self.catUseCase = catUseCase

        catUseCase.publisher
            .sink(receiveValue: { [weak self] cats in
                    self?.cats = cats
                    self?.catListRowViewModels = cats.map { CatListRowViewModel(name: $0.name) }
                  }
            ).store(in: &subscriptions)
    }

    // MARK: - Internal methods

    func selectedCatModel(petListItem: CatListRowViewModel) -> Cat {
        let index = catListRowViewModels.firstIndex { $0.id == petListItem.id }!

        return cats[index]
    }

    func removeCat(at offsets: IndexSet) {
        let cat = offsets.map { cats[$0] }.first!
        catUseCase.delete(cat: cat)
        cats.remove(atOffsets: offsets)
        catListRowViewModels.remove(atOffsets: offsets)
    }
}
