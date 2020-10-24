import SwiftUI

final class EditCatAssembler {
    func assemble(selectedCat: Cat) -> some View {
        let useCase = AppContainer.shared.catUseCase
        let viewModel = EditCatViewModel(selectedCat: selectedCat, catUseCase: useCase)
        let view = EditCatView(viewModel: viewModel)

        return view
    }
}
