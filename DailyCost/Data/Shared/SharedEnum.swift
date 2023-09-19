//
//  SharedEnum.swift
//  DailyCost
//
//  Created by Panji Yoga on 15/09/23.
//

enum DateFormat: String {
    /// "yyyy-MM-dd"
    case serverDate = "yyyy-MM-dd"
    /// "yyyy-MM-dd HH:mm:ss"
    case serverDateWithTime = "yyyy-MM-dd HH:mm:ss"
    /// "dd MMMM yyyy"
    case dayMonthYear = "dd MMMM yyyy"
    /// "dd MMM yyyy"
    case dayMonthYearV2 = "dd MMM yyyy"
    /// "dd MMMM yyyy, HH:mm"
    case dayMonthYearWithTime = "dd MMMM yyyy, HH:mm"
    /// "dd MMMM yyyy HH:mm:ss"
    case dayMonthYearWithTimeV2 = "dd MMMM yyyy HH:mm:ss"
    /// "EEE, dd MMM yyyy
    case weekDayDateMonthYear = "EEE, dd MMM yyyy"
    /// "HH:mm"
    case hourMinute = "HH:mm"
    /// "hh:mm a"
    case hourMinuteAMPM = "hh:mm a"
    /// "HH:mm:ss"
    case hourMinuteSecond = "HH:mm:ss"
    /// "yyyy-MM-dd'T'HH:mm:ss"
    case serverDateWithTimeAndT = "yyyy-MM-dd'T'HH:mm:ss"
    /// "yyy-MM-dd'T'HH:mm:ss.SSS"
    case serverDateWithTimeAndTAndMilis = "yyy-MM-dd'T'HH:mm:ss.SSS"
    /// "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case serverDateWitTimeAndTandZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    /// "E dd-MM-yyyy"
    case dayDateMonthYear = "E dd-MM-yyyy"
    /// "EEEE, dd MMMM yyyy"
    case fullDayDateMonthYear = "EEEE, dd MMMM yyyy"
    /// "EEEE, dd MMMM yyyy HH:mm 'WIB'"
    case fullDayDateMonthYearTimeZone = "EEEE, dd MMMM yyyy HH:mm 'WIB'"
    /// "dd-MM-yyyy"
    case reverseServerDate = "dd-MM-yyyy"
    /// "EEEE"
    case fullDayOnly = "EEEE"
}
