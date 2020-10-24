import NotificationCenter

extension UNNotificationRequest {
    convenience init(localNotification: LocalNotification) {
        let dateComponents = DateComponents(
            hour: localNotification.triggerHours,
            minute: localNotification.triggerMinutes
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let identifier = localNotification.id
        let content = UNMutableNotificationContent()
        content.title = localNotification.title
        content.body = localNotification.body
        content.categoryIdentifier = localNotification.category
        content.sound = UNNotificationSound.default

         self.init(identifier: identifier, content: content, trigger: trigger)
    }
}
