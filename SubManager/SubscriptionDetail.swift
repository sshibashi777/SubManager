//
//  SubscriptionDetail.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/16.
//

import SwiftUI

struct SubscriptionDetail: View {
    @Binding var sub: Subscription
    @Binding var subs: [Subscription]
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingSubscriptionEdit = false
    @State private var newSubscriptionData = Subscription.Data()
    let saveAction: ()->Void
    
    var body: some View {
        ZStack {
            Image("detailBackground")
            
            VStack(spacing: 30) {
                Text(sub.serviceName)
                    .font(.custom("largeTitle", size: 64))
                
                VStack {
                    Text("Subscription renews on:")
                    Text(sub.renewDate.datePursed(), format: .dateTime.year().month().day())
                        .font(.title2)
                }
                
                Text("¥ \(sub.amount)")
                    .font(.largeTitle)
                
                Button {
                    showingSubscriptionEdit = true
                } label: {
                    Text("Edit")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                
                Button {
                    
                } label: {
                    Text("Delete")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .foregroundColor(.black)
        }
        .sheet(isPresented: $showingSubscriptionEdit) {
            NavigationView {
                SubscriptionEdit(data: $newSubscriptionData)
                    .navigationTitle(Text("Add a new subscription"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                showingSubscriptionEdit = false
                                newSubscriptionData = Subscription.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newSub = Subscription(data: newSubscriptionData)
                                subs.append(newSub)
                                showingSubscriptionEdit = false
                                newSubscriptionData = Subscription.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                SubscriptionDetail(sub: .constant(Subscription.sampleData[0]), subs: .constant(Subscription.sampleData), saveAction: {})
            }
        }
    }
}
