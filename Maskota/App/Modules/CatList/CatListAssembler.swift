import SwiftUI

final class CatListAssembler {
    func assemble() -> some View {
        let useCase = AppContainer.shared.catUseCase
        let viewModel = CatListViewModel(catUseCase: useCase)
        let view = CatListView(viewModel: viewModel)

        return view
    }
}
