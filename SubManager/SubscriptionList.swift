
//  SubscriptionList.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.

import SwiftUI

struct SubscriptionList: View {

    @Binding var subs: [Subscription]
    @State private var newSubscriptionData = Subscription.Data()
    @State private var showingDetail = false


    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach($subs) { subscription in
                    NavigationLink(destination: SubscriptionDetail(sub: subscription, newSubscriptionData: subscription, saveAction: {})) {
                        SubscriptionRow(sub: subscription.wrappedValue)
                    }
                }
            }
        }
        .frame(maxHeight: 600)
    }
}

struct SubscriptionList_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionList(subs: .constant(Subscription.sampleData))
    }
}

