import SwiftUI

struct CatListRowView: View {
    var viewModel: CatListRowViewModel

    var body: some View {
        Text(viewModel.name)
    }
}
