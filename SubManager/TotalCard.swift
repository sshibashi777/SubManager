//
//  TotalCard.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/16.
//

import SwiftUI

struct TotalCard: View {
    var subscriptions: [Subscription]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total:")
                .font(.headline)
                .bold()
            
            Text("90000")
                .font(.largeTitle)
                .bold()
        }
        .frame(maxWidth: 370, maxHeight: 170)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}


struct TotalCard_Previews: PreviewProvider {
    static var previews: some View {
        TotalCard(subscriptions: Subscription.sampleData)
    }
}
