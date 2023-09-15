//
//  String+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

import Foundation

extension String {
    func convertDateString(fromFormat: DateFormat, toFormat: DateFormat) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat.rawValue
            dateFormatter.locale = Constants.DefaultLocale
            let convertedString = dateFormatter.string(from: date)
            return convertedString
        } else {
            return nil
        }
    }
    
    func formatDate(from format: DateFormat, to expectedFormat: DateFormat) -> String {
        guard let date = toDate(with: format) else { return self }
        return date.toString(with: expectedFormat)
    }
    
    func toDate(with format: DateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Constants.DefaultLocale
        return formatter.date(from: self)
    }
}
