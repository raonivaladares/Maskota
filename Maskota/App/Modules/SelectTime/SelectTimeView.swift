import SwiftUI

struct SelectTimeView: View {

    // MARK: - Private properties

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var selectedTimeDTO: SelectedTimeDTO
    @State private var date = Date()

    init(selectedTimeDTO: SelectedTimeDTO) {
        self.selectedTimeDTO = selectedTimeDTO
    }

    // MARK: - Internal properties

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $date,  displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
            }
            .navigationBarTitle("Time selection")
            .navigationBarItems(
                leading: Button("Cancel", action: onCancelButtonTapped),
                trailing: Button("Done", action: onDoneButtonTapped)
            )
        }
    }

    // MARK: - Private Methods

    private func onCancelButtonTapped() {
        selectedTimeDTO.time = nil
        presentationMode.wrappedValue.dismiss()
    }

    private func onDoneButtonTapped() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)

        selectedTimeDTO.time = .init(hour: hour, minutes: minutes)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Previews

struct SelectTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTimeView(selectedTimeDTO: .init())
    }
}
