import SwiftUI

final class EditCatViewModel: ObservableObject {

    // MARK: - Private properties

    private let selectedCat: Cat
    private let catUseCase: CatUseCases
    private var selectedTimes: [FeedTime] = []

    // MARK: - Internal properties

    @Published var isDoneDisabled = true
    @Published var name: String? { didSet { validateName() } }
    @Published var feedTimes: [SelectedTimeListItem] = []

    // MARK: - Inits

    init(selectedCat: Cat, catUseCase: CatUseCases = AppContainer.shared.catUseCase) {
        self.selectedCat = selectedCat
        self.catUseCase = catUseCase

        name = selectedCat.name
        selectedTimes = selectedCat.feedTimes
        feedTimes = selectedCat.feedTimes.compactMap { .init(time: "hour: \($0.hours) minutes: \($0.minutes)") }
    }

    // MARK: - Private methods

    private func validateName() {
        isDoneDisabled = name?.isEmpty ?? true
    }

    // MARK: - Internal methods

    func addNew(selectedTime: SelectedTimeDTO.Time) {
        let feedTime = FeedTime(localID: UUID().uuidString, hours: selectedTime.hour, minutes: selectedTime.minutes)
        selectedTimes.append(feedTime)

        feedTimes.append(.init(time: "hour: \(selectedTime.hour) minutes: \(selectedTime.minutes)"))
    }

    func removeFeedTime(at offsets: IndexSet) {
        selectedTimes.remove(atOffsets: offsets)
        feedTimes.remove(atOffsets: offsets)
    }

    func updateCat() {
        let cat = Cat(localID: selectedCat.localID, name: name ?? "", feedTimes: selectedTimes)
        catUseCase.save(cat: cat)
    }
}

struct SelectedTimeListItem: Identifiable {
    var id = UUID()
    var time: String
}
