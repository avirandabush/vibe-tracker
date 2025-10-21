//
//  Date+Ext.swift
//  VibeTracker
//
//  Created by Aviran Dabush on 21/10/2025.
//

import Foundation

extension Date {
    var startOfWeek: Date {
        var cal = Calendar.current
        cal.firstWeekday = 1
        let comps = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return cal.date(from: comps) ?? self
    }
}
