import SwiftUI

@main
struct MaskotaApp: App {
    private let localNotificationManager = LocalNotificationManager(
        catUseCases: AppContainer.shared.catUseCase,
        notificationCenter: UserNotificationCenterImp(),
        localNotificationFactory: LocalNotificationFactory()
    )

    var body: some Scene {
        WindowGroup {
            CatListAssembler().assemble()
        }
    }
}
