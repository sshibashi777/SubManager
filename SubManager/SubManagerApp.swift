//
//  SubManagerApp.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI

@main
struct SubManagerApp: App {
    @StateObject private var store = SubscribeStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ContentView(subs: $store.subs, sub: $store.sub, newSubscriptionData: $store.sub) {
                Task {
                    do {
                        try await SubscribeStore.save(subs: store.subs)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    store.subs = try await SubscribeStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "SubManager will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.subs = Subscription.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
