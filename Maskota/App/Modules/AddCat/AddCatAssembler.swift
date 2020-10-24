import SwiftUI

final class AddCatAssembler {
    func assemble() -> some View {
        let useCase = AppContainer.shared.catUseCase
        let viewModel = AddCatViewModel(catUseCase: useCase)
        let view = AddCatView(viewModel: viewModel)

        return view
    }
}
