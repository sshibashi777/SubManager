//
//  ContentView.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI

struct ContentView: View {
    @Binding var subs: [Subscription]
    @Binding var sub: Subscription
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingSubscriptionEdit = false
    @State private var newSubscriptionData = Subscription.Data()
    let saveAction: ()->Void
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    TotalCard(subscriptions: subs)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    
                    SubscriptionList(subs: $subs, sub: $sub)
                }
            }
            .navigationTitle(Text("Subscriptions"))
            .navigationViewStyle(.stack)
            .toolbar {
                Button(action: {
                    showingSubscriptionEdit = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $showingSubscriptionEdit) {
                NavigationView {
                    SubscriptionEdit(data: $newSubscriptionData)
                        .navigationTitle(Text("Add/edit subscription"))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingSubscriptionEdit = false
                                    newSubscriptionData = Subscription.Data()
                                }
                                .foregroundColor(.red)
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
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(subs: .constant(Subscription.sampleData), sub: .constant(Subscription.sampleData[0]), saveAction: {})
        }
    }
}

