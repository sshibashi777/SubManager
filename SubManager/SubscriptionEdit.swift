//
//  SubscriptionEdit.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI

struct SubscriptionEdit: View {
    @Binding var data: Subscription.Data
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Renew date")) {
                    DatePicker("Choose date", selection: $data.date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .onChange(of: data.date, perform: { date in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            data.renewDate = dateFormatter.string(from: date) as String
                        })
                }
                Section(header: Text("Service name")) {
                    TextField("Enter service name here", text: $data.serviceName)
                }
                Section(header: Text("Amount")) {
                    TextField("Enter paying amount here", text: $data.amount)
                        .keyboardType(.numberPad)
                }
            }
        }
    }
}


struct SubscriptionEdit_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionEdit(data: .constant(Subscription.sampleData[0].data))
    }
}
