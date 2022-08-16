//
//  SubscriptionModel.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import Foundation

struct Subscription: Identifiable, Codable {
    let id: UUID
    var renewDate: String
    var serviceName: String
    var amount: String
    
    var datePursed: Date {
        renewDate.datePursed()
    }
    
    init(id: UUID = UUID(), renewDate: String, serviceName: String, amount: String) {
        self.id = id
        self.renewDate = renewDate
        self.serviceName = serviceName
        self.amount = amount
    }
}

extension Subscription {
    struct Data {
        var date: Date = Date()
        var renewDate: String = ""
        var serviceName: String = ""
        var amount: String = "500"
    }
    
    var data: Data {
        Data(renewDate: renewDate, serviceName: serviceName, amount: amount)
    }
    
    mutating func update(from data: Data) {
        renewDate = data.renewDate
        serviceName = data.serviceName
        amount = data.amount
    }
    
    init(data: Data) {
        id = UUID()
        renewDate = data.renewDate
        serviceName = data.serviceName
        amount = data.amount
    }
}

extension Subscription {
    static let sampleData: [Subscription] =
    [
        Subscription(renewDate: "08/20/2022", serviceName: "Netflix", amount: "980"),
        Subscription(renewDate: "08/19/2022", serviceName: "SoftBank", amount: "5000"),
        Subscription(renewDate: "09/03/2022", serviceName: "Amazon Prime", amount: "540"),
        Subscription(renewDate: "05/06/2023", serviceName: "Creative Cloud", amount: "26000"),
        Subscription(renewDate: "08/17/2022", serviceName: "iCloud+", amount: "500"),
        Subscription(renewDate: "04/18/2023", serviceName: "Microsoft 365", amount: "12000")
    ]
}
