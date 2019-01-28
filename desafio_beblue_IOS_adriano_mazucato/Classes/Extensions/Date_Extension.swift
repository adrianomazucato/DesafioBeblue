//
//  Date_Extension.swift
//  desafio_beblue_IOS_adriano_mazucato
//
//  Created by Adriano Mazucato on 25/01/2019.
//  Copyright © 2019 Adriano Mazucato. All rights reserved.
//

import UIKit

public extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat =  dateFormat
    }
}

extension Date {
    public struct Formatter {
        public static let apiFormatterDate = DateFormatter(dateFormat: "yyyy-MM-dd")
    }
    
    public var apiFormatterDate: String {
        return Formatter.apiFormatterDate.string(from: self)
    }
    
    public func addDay(_ day: Int) -> Date! {
        return (Calendar(identifier: Calendar.Identifier.gregorian) as NSCalendar).date(byAdding: .day, value: day, to: self, options: [])
    }
}
