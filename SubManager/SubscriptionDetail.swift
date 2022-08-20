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
    @Binding var  newSubscriptionData: Subscription
    @State private var editIsPressed = false
    @State private var deleteIsPressed = false
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
                
                Capsule()
                    .frame(width: 90, height: 60, alignment: .center)
                    .foregroundColor(.blue)
                    .overlay(Text("\(Image(systemName: "pencil"))Edit"))
                    .font(.title2)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showingSubscriptionEdit = true
                    }
                    .scaleEffect(editIsPressed ? 0.8 : 1.0)
                    .pressEvents {
                        withAnimation(.easeIn(duration: 0.05)) {
                            editIsPressed = true
                        }
                    } onRelease: {
                        withAnimation {
                            editIsPressed = false
                        }
                    }
                
                
                Button {
                    subs.remove(at: subs.count - 1)
                } label: {
                    Text("\(Image(systemName: "trash"))Delete")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .scaleEffect(deleteIsPressed ? 0.8 : 1.0)
                .pressEvents {
                    withAnimation(.easeIn(duration: 0.05)) {
                        deleteIsPressed = true
                    }
                } onRelease: {
                    withAnimation {
                        deleteIsPressed = false
                    }
                }
            }
            .padding(30)
            .foregroundColor(Color("textColor"))
            .background(.ultraThinMaterial)
            .cornerRadius(25)
            .shadow(color: Color("textColor").opacity(0.3), radius: 5, x: 4, y: 4)
            .shadow(color: Color("textColor").opacity(0.3), radius: 5, x: -4, y: -4)
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
                            }
                            .foregroundColor(.red)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingSubscriptionEdit = false
                                newSubscriptionData = sub
                            }
                            .disabled(newSubscriptionData.serviceName.isEmpty)
                            .disabled(newSubscriptionData.amount.isEmpty)
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
                SubscriptionDetail(sub: .constant(Subscription.sampleData[1]), subs: .constant(Subscription.sampleData),  newSubscriptionData: .constant(Subscription.sampleData[1]),  saveAction: {})
            }
            NavigationView {
                SubscriptionDetail(sub: .constant(Subscription.sampleData[1]), subs: .constant(Subscription.sampleData),  newSubscriptionData: .constant(Subscription.sampleData[1]),  saveAction: {})
                    .preferredColorScheme(.dark)
            }
        }
    }
}
