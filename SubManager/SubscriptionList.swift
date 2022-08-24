
//  SubscriptionList.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.

import SwiftUI

struct SubscriptionList: View {
    
    @Binding var subs: [Subscription]
    @Binding var sub: Subscription
    @State private var showingDetail = false
    @State private var notifyIsPressed = false
    @State private var showingAlert = false
    let manager = LocalNotificationManager()
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(subs.indices, id: \.self) {index in
                    NavigationLink(destination: SubscriptionDetail(sub: $subs[index], subs: $subs, newSubscriptionData: $subs[index], saveAction: {})
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("\(Image(systemName: "bell.circle"))") {
                                    let newNotification = Notification(id: "Notification-\(manager.notificationId)", title: sub.serviceName, datetime: sub.date)
                                    
                                    manager.notifications.append(newNotification)
                                    manager.schedule()
                                    manager.notificationId += 1
                                    showingAlert = true
                                    print(manager.notifications)
                                }
                                .alert("Notification Added", isPresented: $showingAlert) {
                                    Button("OK", role: .cancel) {}
                                }
                                .font(.largeTitle)
                                .scaleEffect(notifyIsPressed ? 0.8 : 1.0)
                                .pressEvents {
                                    withAnimation(.easeIn(duration: 0.05)) {
                                        notifyIsPressed = true
                                    }
                                } onRelease: {
                                    withAnimation {
                                        notifyIsPressed = false
                                    }
                                }
                            }
                        }
                    )
                    {
                        SubscriptionRow(sub: $subs[index])
                    }
                }
            }
        }
        .frame(maxHeight: 600)
    }
}

struct SubscriptionList_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionList(subs: .constant(Subscription.sampleData), sub: .constant(Subscription.sampleData[1]))
    }
}

