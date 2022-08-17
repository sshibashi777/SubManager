//
//  SubscriptionEdit.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI

struct SubscriptionEdit: View {
    @Binding var sub: Subscription
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Renew date")) {
                    DatePicker("Choose date", selection: $sub.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .onChange(of: sub.date, perform: { date in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            sub.renewDate = dateFormatter.string(from: date) as String
                        })
                }
                Section(header: Text("Service name")) {
                    TextField("Enter service name here", text: $sub.serviceName)
                }
                Section(header: Text("Amount")) {
                    TextField("Enter paying amount here", text: $sub.amount)
                        .keyboardType(.numberPad)
                }
            }
        }
    }
}


struct SubscriptionEdit_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionEdit(sub: .constant(Subscription.sampleData[1]))
    }
}
