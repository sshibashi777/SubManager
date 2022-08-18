//
//  SubscriptionRow.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import SwiftUI

struct SubscriptionRow: View {
    @Binding var sub: Subscription
    
    var body: some View {
        HStack {
            Text(sub.serviceName)
                .font(.title)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("¥\(sub.amount)")
                    .font(.headline)
                    .bold()
                
                Text("Renews: \(sub.datePursed, format: .dateTime.year().month().day())")
                    .font(.caption)
            }
        }
        .foregroundColor(Color("textColor"))
        .padding()
        .background(.ultraThinMaterial)
        .frame(maxWidth: 370, maxHeight: 70)
        .cornerRadius(15)
    }
}

struct ServiceColumn_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionRow(sub: .constant(Subscription.sampleData[0]))
            .background(.ultraThinMaterial)
            .previewLayout(.fixed(width: 370, height: 70))
    }
}
