//
//  SubscriptionDetail.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/16.
//

import SwiftUI

struct SubscriptionDetail: View {
    @Binding var sub: Subscription
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingSubscriptionEdit = false
    @Binding var  newSubscriptionData: Subscription
    let saveAction: ()->Void
    
    var body: some View {
        ZStack {
            Image("background")
            
            VStack(alignment: .center, spacing: 30) {
                Text(sub.serviceName)
                    .font(.custom("largeTitle", size: 48))
                    .bold()
                
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
                        .foregroundColor(.white)
                }
                .frame(width: 100, height: 50)
                .background(.blue)
                .cornerRadius(25)
                
                Button {
                    
                } label: {
                    Text("Delete")
                        .font(.title)
                        .foregroundColor(.red)
                }
            }
            .padding(30)
            .foregroundColor(Color("textColor"))
            .background(.ultraThinMaterial)
            .cornerRadius(25)
        }
        .sheet(isPresented: $showingSubscriptionEdit) {
            NavigationView {
                SubscriptionEdit(sub: $newSubscriptionData)
                    .navigationTitle(Text("Edit subscription"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingSubscriptionEdit = false
                                newSubscriptionData = sub
                            }
                            .foregroundColor(.red)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingSubscriptionEdit = false
                                newSubscriptionData = sub
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
                SubscriptionDetail(sub: .constant(Subscription.sampleData[0]), newSubscriptionData: .constant(Subscription.sampleData[0]),  saveAction: {})
            }
            NavigationView {
                SubscriptionDetail(sub: .constant(Subscription.sampleData[0]), newSubscriptionData: .constant(Subscription.sampleData[0]),  saveAction: {})
                    .preferredColorScheme(.dark)
            }
        }
    }
}
