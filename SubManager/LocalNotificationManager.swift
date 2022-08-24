//
//  LocalNotificationManager.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/24.
//

import Foundation
import SwiftUI

class LocalNotificationManager: ObservableObject {
    
    var notifications = [Notification]()
    var notificationId = 1
    
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            
            for notification in notifications {
                print(notification)
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            
            if granted == true && error == nil {
                self.scheduleNotifications()
                print("Notifications permitted ✅")
            } else {
                print("Notifications not permitted ❌: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break // Do nothing
            }
        }
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.sound = .default
            let n = 7
            let nextTrigger = Calendar.current.date(byAdding: .day, value: n, to: Date())!
            let comps = Calendar.current.dateComponents([.year, .month, .day, .hour], from: nextTrigger)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
    
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Notification scheduled! ID: \(notification.id)")
            }
        }
    }
}

struct Notification {
    var id: String
    var title: String
    var datetime: Date
}


