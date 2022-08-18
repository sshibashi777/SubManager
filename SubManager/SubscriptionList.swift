
//  SubscriptionList.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.

import SwiftUI

struct SubscriptionList: View {

    @Binding var subs: [Subscription]
    @Binding var sub: Subscription
    @State private var showingDetail = false


    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(subs.indices, id: \.self) {index in
                    NavigationLink(destination: SubscriptionDetail(sub: $subs[index], subs: $subs, newSubscriptionData: $subs[index], saveAction: {})) {
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

