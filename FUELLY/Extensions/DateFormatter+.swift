//
//  DateFormatter+.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 04.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func standart(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Calendar.current.isDateInToday(date)  ? "HH:mm" : "HH:mm E, d MMM y"
        return formatter.string(from: date)
    }
}
