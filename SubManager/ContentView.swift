//
//  ContentView.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI
struct ContentView: View {
    @Binding var subs: [Subscription]
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingSubscriptionEdit = false
    @Binding var newSubscriptionData: Subscription
    @Binding var brandNewSubscriptionData: Subscription
    @State private var showingHelp = false
    let saveAction: ()->Void
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    SubscriptionList(subs: $subs)
                        .padding(.top, 100)
                }
                if subs.isEmpty {
                    VStack {
                        Text("No subscriptions yet")
                            .font(.title3)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                        Button {
                            showingHelp = true
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.largeTitle)
                                .padding()
                        }
                    }
                } else {
                    Text("")
                }
            }
            .navigationTitle(Text("Subscriptions"))
            .navigationViewStyle(.stack)
            .toolbar {
                Button {
                    showingSubscriptionEdit = true
                    newSubscriptionData = Subscription.sampleData[0]
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(Color("textColor"))
                }
            }
        }
        .sheet(isPresented: $showingSubscriptionEdit) {
            NavigationView {
                SubscriptionEdit(sub: $newSubscriptionData)
                    .navigationTitle(Text("Add a new subscription"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingSubscriptionEdit = false
                                
                            }
                            .foregroundColor(.red)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                subs.append(newSubscriptionData)
                                showingSubscriptionEdit = false
                            }
                        }
                    }
            }
        }
        .sheet(isPresented: $showingHelp) {
            VStack(spacing: 30) {
                VStack {
                    Text("How to use this app")
                        .font(.custom("title", size: 32))
                        .padding(.top, 30)
                    
                    Text("🧐")
                        .font(.largeTitle)
                }
                
                ScrollView {
                    VStack {
                        HStack(alignment: .top) {
                            Spacer()
                            
                            Text("1.")
                                .font(.custom("largeTitle", size: 100))
                            
                            Spacer()
                            
                            VStack {
                                Text("Tap the add button")
                                    .frame(width: 200, height: 40)
                                
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        HStack(alignment: .top) {
                            Spacer()
                            
                            Text("2.")
                                .font(.custom("largeTitle", size: 100))
                            
                            Spacer()
                            
                            VStack {
                                Text("Choose the date your subscription renews")
                                    .frame(width: 200, height: 70)
                                
                                Image("datePicker")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text("3.")
                                .font(.custom("largeTitle", size: 100))
                            
                            Spacer()
                            
                            VStack {
                                Text("Enter the name of the servie")
                                    .frame(width: 200, height: 70)
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Text("4.")
                                .font(.custom("largeTitle", size: 100))
                            
                            Spacer()
                            
                            VStack {
                                Text("Enter the amount you pay monthly/annualy")
                                    .frame(width: 200, height: 70)
                            }
                            .padding(.top, 10)
                            
                            Spacer()
                        }
                        
                        Button {
                            showingHelp = false
                        } label: {
                            Text("Understood!")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 250, height: 40)
                        }
                        .background(.blue)
                        .cornerRadius(25)
                        .padding(.bottom, 30)
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
        ContentView(subs: .constant(Subscription.sampleData),  newSubscriptionData: .constant(Subscription.sampleData[1]), brandNewSubscriptionData: .constant(Subscription.sampleData[1]), saveAction: {})
        ContentView(subs: .constant(Subscription.sampleData),  newSubscriptionData: .constant(Subscription.sampleData[1]), brandNewSubscriptionData: .constant(Subscription.sampleData[1]), saveAction: {})
            .preferredColorScheme(.dark)
    }
}


