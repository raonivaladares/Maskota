import SwiftUI

struct AddCatView: View {

    // MARK: - Private properties

    @StateObject private var viewModel: AddCatViewModel
    @State private var isShowingSelectTimeView = false
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var selectedTimeDTO = SelectedTimeDTO()

    // MARK: - Internal properties

    var body: some View {
        NavigationView {
            VStack {
                Text("What is your cat name?")
                TextField("Enter your name",
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
            .navigationBarTitle("Adding a new cat")
            .navigationBarItems(
                leading: Button("Cancel") { presentationMode.wrappedValue.dismiss() },
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
    }

    // MARK: - Inits

    init(viewModel: AddCatViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Private methods

    private func onDismiss() {
        self.isShowingSelectTimeView = false
        if let feedTime = selectedTimeDTO.time {
            viewModel.addNew(selectedTime: feedTime)
        }
        self.selectedTimeDTO.time = nil
    }

    private func onDoneButtonTapped() {
        viewModel.createCat()
        self.presentationMode.wrappedValue.dismiss()
    }

    private func onDeleteRow(at offsets: IndexSet) {
        viewModel.removeFeedTime(at: offsets)
    }
}

// MARK: - Previews

struct AddPetView_Previews: PreviewProvider {
    static var previews: some View {
        AddCatView(viewModel: .init())
    }
}
