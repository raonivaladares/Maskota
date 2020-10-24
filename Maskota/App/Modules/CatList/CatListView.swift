import SwiftUI

struct CatListView: View {

    // MARK: - Private properties

    @StateObject private var viewModel: CatListViewModel
    @State private var isShowingAddCatView = false

    // MARK: - Inits

    init(viewModel: CatListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Internal properties

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.catListRowViewModels, id: \.id) { petListItem in
                    let cat = viewModel.selectedCatModel(petListItem: petListItem)
                    let view = EditCatAssembler().assemble(selectedCat: cat)

                    NavigationLink(destination: view) { CatListRowView(viewModel: petListItem) }
                }.onDelete(perform: onDelete)
            }
            .navigationBarTitle("Pets")
            .navigationBarItems(trailing: Button("Add") { isShowingAddCatView = true })
            .sheet(
                isPresented: $isShowingAddCatView,
                onDismiss: { isShowingAddCatView = false },
                content: { AddCatAssembler().assemble() }
            )
        }
    }

    // MARK: - Private methods

    private func onDelete(at offsets: IndexSet) {
        viewModel.removeCat(at: offsets)
    }
}

// MARK: - Previews

struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView(viewModel: .init())
    }
}
