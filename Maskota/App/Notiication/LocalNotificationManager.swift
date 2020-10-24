import NotificationCenter
import Combine

final class LocalNotificationManager {

    // MARK: - Private properties

    private let catUseCases: CatUseCase
    private let notificationCenter: UserNotificationCenter
    private let localNotificationFactory: LocalNotificationFactory
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Inits

    init(catUseCases: CatUseCase,
         notificationCenter: UserNotificationCenter,
         localNotificationFactory: LocalNotificationFactory) {

        self.catUseCases = catUseCases
        self.notificationCenter = notificationCenter
        self.localNotificationFactory = localNotificationFactory

        notificationCenter.requestPermission()

        catUseCases.publisher
            .sink(receiveValue: { [weak self] cats in
                guard let self = self else { return }

                self.notificationCenter
                    .removeAllPendingRequests()
                self.createRequests(from: cats)
                    .forEach(self.notificationCenter.add)
            }).store(in: &subscriptions)
    }

    // MARK: - Private methods

    private func createRequests(from models: [Cat]) -> [UNNotificationRequest] {
        models.flatMap { $0.feedTimes }
            .map(localNotificationFactory.create)
            .map(UNNotificationRequest.init)
            .distinct { $0.identifier }
    }
}
