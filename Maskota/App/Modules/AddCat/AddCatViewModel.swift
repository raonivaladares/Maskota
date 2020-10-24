import SwiftUI

final class AddCatViewModel: ObservableObject {

    // MARK: - Private properties

    private let catUseCase: CatUseCases
    private var selectedTimes: [FeedTime] = []

    // MARK: - Internal properties

    @Published var isDoneDisabled = true
    @Published var name: String? { didSet { validateName() } }
    @Published var feedTimes: [SelectedTimeListItem] = []

    // MARK: - Inits

    init(catUseCase: CatUseCases = AppContainer.shared.catUseCase) {
        self.catUseCase = catUseCase
    }

    // MARK: - Internal methods

    func addNew(selectedTime: SelectedTimeDTO.Time) {
        selectedTimes.append(.init(localID: UUID().uuidString, hours: selectedTime.hour, minutes: selectedTime.minutes))
        feedTimes.append(.init(time: "hour: \(selectedTime.hour) minutes: \(selectedTime.minutes)"))
    }

    func removeFeedTime(at offsets: IndexSet) {
        selectedTimes.remove(atOffsets: offsets)
        feedTimes.remove(atOffsets: offsets)
    }

    func createCat() {
        let cat = Cat(localID: UUID().uuidString, name: name ?? "", feedTimes: selectedTimes)
        catUseCase.save(cat: cat)
    }

    // MARK: - Private methods

    private func validateName() {
        isDoneDisabled = name?.isEmpty ?? true
    }
}
