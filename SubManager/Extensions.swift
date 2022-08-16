//
//  Extensions.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/15.
//

import Foundation
import SwiftUI

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String {
    func datePursed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date()}
        
        return parsedDate
    }
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedToTwoDigits() -> Double {
        return (self * 100).rounded() / 100
    }
}
