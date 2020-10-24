struct LocalNotificationFactory {
    func create(feedTime: FeedTime) -> LocalNotification {
        .init(
            id: "feed_time_\(feedTime.hours)_\(feedTime.minutes)",
            title: "Feed Time",
            body: "It's time to feed your friends: \(feedTime.hours) : \(feedTime.minutes)",
            category: "feed_time",
            triggerHours: feedTime.hours,
            triggerMinutes: feedTime.minutes
        )
    }
}
