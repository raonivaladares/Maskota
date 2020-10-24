import SwiftUI

struct EditCatView: View {

    // MARK: - Private properties

    @StateObject private var viewModel: EditCatViewModel
    @State private var isShowingSelectTimeView = false
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var selectedTimeDTO = SelectedTimeDTO()

    // MARK: - Internal properties

    var body: some View {
        VStack {
            Text("Cat name")
            TextField("Enter your cat name",
                      text: Binding<String>(
                        get: { viewModel.name ?? "" },
                        set: { viewModel.name = $0 }
                      )
            ).textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer(minLength: 30)
            HStack {
                Text("Feed time")
                Spacer()
                Button("Add") { isShowingSelectTimeView = true }
            }
            List {
                ForEach(viewModel.feedTimes, id: \.id) { item in
                    Text(item.time)
                }.onDelete(perform: onDeleteRow)
            }
        }.padding(32)
        .navigationBarTitle("Edit cat")
        .navigationBarItems(
            trailing: Button(
                "Done",
                action: onDoneButtonTapped
            ).disabled(viewModel.isDoneDisabled)
        ).sheet(
            isPresented: $isShowingSelectTimeView,
            onDismiss: onDismiss,
            content: { SelectTimeView(selectedTimeDTO: selectedTimeDTO) }
        )
    }

    // MARK: - Inits

    init(viewModel: EditCatViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Private methods

    private func onDismiss() {
        isShowingSelectTimeView = false
        if let feedTime = selectedTimeDTO.time {
            viewModel.addNew(selectedTime: feedTime)
        }
        selectedTimeDTO.time = nil
    }

    private func onDoneButtonTapped() {
        viewModel.updateCat()
        presentationMode.wrappedValue.dismiss()
    }

    private func onDeleteRow(at offsets: IndexSet) {
        viewModel.removeFeedTime(at: offsets)
    }
}
