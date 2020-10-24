import UserNotifications

protocol UserNotificationCenter {
    func requestPermission() -> Void
    func add(request: UNNotificationRequest)
    func removeAllPendingRequests()
}

struct UserNotificationCenterImp: UserNotificationCenter {
    private let notificationCenter = UNUserNotificationCenter.current()

    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    print("granted")
                }

                if granted == false {
                    print("not granted")
                }

                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }

    func add(request: UNNotificationRequest) {
        notificationCenter.add(request)
    }

    func removeAllPendingRequests() {
        allNotification()
        notificationCenter.removeAllPendingNotificationRequests()
    }

    private func allNotification() {
        notificationCenter.getPendingNotificationRequests { notifications in
            notifications.forEach { print($0) }
        }
    }
}
