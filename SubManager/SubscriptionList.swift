
//  SubscriptionList.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.

import SwiftUI

struct SubscriptionList: View {

    @Binding var subs: [Subscription]
    @Binding var sub: Subscription
    @State private var newSubscriptionData = Subscription.Data()
    @State private var showingDetail = false


    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach($subs) { $subscription in
                    NavigationLink(destination: SubscriptionDetail(sub: $sub, subs: $subs, saveAction: {})) {
                        SubscriptionRow(sub: subscription)
                    }
                }
            }
        }
        .frame(height: 400)
    }
}

struct SubscriptionList_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionList(subs: .constant(Subscription.sampleData), sub: .constant(Subscription.sampleData[0]))
    }
}

