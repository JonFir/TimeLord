//
//  TimeLord.swift
//  TestProject
//
//  Created by Евгений Елчев on 04.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

import Foundation


extension Date {
    
    public static var toStringFormat: String{
       return "yyyy-MM-dd HH:mm:ss"
    }
    
    public var era: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.era!
        }
    }
    public var year: Int
        {
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.year!
        }
    }
    public var month: Int
        {
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.month!
        }
    }
    public var day: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.day!
        }
    }
    public var dayInMonth: Int{
        get{
            return (Calendar.current as NSCalendar).range(of: .day, in: .month, for: self).length
        }
    }
    public var hour: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.hour!
        }
    }
    public var minute: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.minute!
        }
    }
    public var second: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.second!
        }
    }
    public var nanosecond: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.nanosecond!
        }
    }
    public var weekday: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.weekday!
        }
    }
    public var weekdaySymbol: String{
        get{
            return Calendar.current.weekdaySymbols[self.weekday - 1]
        }
    }
    public var weekdayOrdinal: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.weekdayOrdinal!
        }
    }
    public var quarter: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.quarter!
        }
    }
    public var weekOfMonth: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.weekOfMonth!
        }
    }
    public var weekOfYear: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.weekOfYear!
        }
    }
    public var yearForWeekOfYear: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self)
            return dateComponents.yearForWeekOfYear!
        }
    }

    public static func NSDateFromYear(
        _ year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int,
        second: Int,
        timeZone: TimeZone? = nil
    ) -> Date?
    {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        if let timeZone = timeZone{
            (dateComponents as NSDateComponents).timeZone = timeZone
        }
        
        dateComponents.timeZone = timeZone

        return Calendar.current.date(from: dateComponents)
    }
    
    public static func NSDateFromString(_ date: String, inFormat: String? = nil, timeZone: TimeZone? = nil) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = inFormat ?? self.toStringFormat
        
        if let timeZone = timeZone {
            dateFormater.timeZone = timeZone
        }
        
        return dateFormater.date(from: date)
    }

    
    public static func NSDateAtKeyWord(_ keyWord: DateKeyWord) -> Date{
        switch keyWord {
        case .now:
            return Date()
        case .today:
            return Date.NSDateAtKeyWord(.now).startOfDay()
        case .tomorrow:
            return Date.NSDateAtKeyWord(.today).addDays(1)!
        case .yesterday:
            return Date.NSDateAtKeyWord(.today).subDays(1)!
        }
    }
    
    public enum DateUnit{
        case era
        case year
        case month
        case day
        case hour
        case minute
        case second
        case nanosecond
        case weekday
        case weekdayOrdinal
        case quarter
        case weekOfMonth
        case weekOfYear
        case yearForWeekOfYear
    }
    
    public enum DateKeyWord{
        case now
        case today
        case tomorrow
        case yesterday
    }
    
    public func toStringInFormat(_ format: String, inTimeZone: TimeZone? = nil) -> String{
        let dateformater = DateFormatter()
        dateformater.dateFormat = format
        
        if let timeZone = inTimeZone {
            dateformater.timeZone = timeZone
        }
        
        return dateformater.string(from: self)
    }
    
    public func toString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat(Date.toStringFormat, inTimeZone: inTimeZone)
    }
    
    public func toFormattedDateString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("MMM d, YYYY", inTimeZone: inTimeZone)
    }
    
    public func toTimeString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    public func toDateTimeString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    public func toDayDateTimeString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("E, MMM d, YYYY h:mm a", inTimeZone: inTimeZone)
    }
    
    public func toIso8601String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc850String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    public func toRfc1123String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc2822String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc3339String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRssString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toW3cString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc1036String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc822String(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toAtomString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toCookieString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yyyy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    /* COMPARISONS */
    
    
    
    public func between (_ first: Date, second: Date) -> Bool{
        return (first < self) && (self < second )
    }
    
    public func closest(_ first: Date, second: Date) -> Date{
        return self.diffInSeconds(first) < self.diffInSeconds(second)  ? first : second
    }
    
    public func farthest(_ first: Date, second: Date) -> Date{
        return self.diffInSeconds(first) > self.diffInSeconds(second)  ? first : second
    }
    
    public func earlier(_ date: Date) -> Date{
        return (self as NSDate).earlierDate(date)
    }
    
    public func later(_ date: Date) -> Date{
        return (self as NSDate).laterDate(date)
    }
    
    public func isWeekend() -> Bool{
        return Calendar.current.isDateInWeekend(self)
    }
    
    public func isYesterday() -> Bool{
        return Calendar.current.isDateInYesterday(self)
    }
    
    public func isToday() -> Bool{
        return Calendar.current.isDateInToday(self)
    }
    
    public func isTomorrow() -> Bool{
        return Calendar.current.isDateInTomorrow(self)
    }
    
    public func isFuture() -> Bool{
        return self > Date.NSDateAtKeyWord(.now)
    }
    
    public func isPast() -> Bool{
        return self < Date.NSDateAtKeyWord(.now)
    }
    
    public func isLeapYear() -> Bool{
        return (( self.year%100 != 0) && (self.year%4 == 0)) || (self.year%400 == 0);
    }
    
    public func isSameDay(_ date: Date) -> Bool{
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    public func isSunday() -> Bool{
        return self.weekday == 1
    }
    
    public func isMonday() -> Bool{
        return self.weekday == 2
    }
    
    public func isTuesday() -> Bool{
        return self.weekday == 3
    }
    
    public func isWednesday() -> Bool{
        return self.weekday == 4
    }
    
    public func isThursday() -> Bool{
        return self.weekday == 5
    }
    
    public func isFriday() -> Bool{
        return self.weekday == 6
    }
    
    public func isSaturday() -> Bool{
        return self.weekday == 7
    }
    
    /* ADDITIONS AND SUBTRACTION */
    
    fileprivate func changeTimeInterval(_ timeInterval: DateUnit, value: Int, modyfer: Int) -> Date? {
        
        let modyfedValue = value * modyfer
        
        var dateComponent = DateComponents()
        
        switch timeInterval {
        case .second:
            dateComponent.second = modyfedValue
        case .minute:
            dateComponent.minute = modyfedValue
        case .hour:
            dateComponent.hour = modyfedValue
        case .day:
            dateComponent.day = modyfedValue
        case .weekOfMonth:
            dateComponent.day = modyfedValue * 7
        case .month:
            dateComponent.month = modyfedValue
        case .year:
            dateComponent.year = modyfedValue
        default:
            return nil
        }
        
        let calendar = Calendar.current
        
        return (calendar as NSCalendar).date(byAdding: dateComponent, to: self, options: .matchFirst)
    }
    
    public func addYears(_ years: Int) -> Date?{
        return self.changeTimeInterval(.year, value: years, modyfer: 1)
    }
    
    public func subYears(_ years: Int) -> Date?{
        return self.changeTimeInterval(.year, value: years, modyfer: -1)
    }
    
    public func addMonths(_ months: Int) -> Date?{
        return self.changeTimeInterval(.month, value: months, modyfer: 1)
    }
    
    public func subMonths(_ months: Int) -> Date?{
        return self.changeTimeInterval(.month, value: months, modyfer: -1)
    }
    
    public func addDays(_ days: Int) -> Date?{
        return self.changeTimeInterval(.day, value: days, modyfer: 1)
    }
    
    public func subDays(_ days: Int) -> Date?{
        return self.changeTimeInterval(.day, value: days, modyfer: -1)
    }
    
    public func addHours(_ hours: Int) -> Date?{
        return self.changeTimeInterval(.hour, value: hours, modyfer: 1)
    }
    
    public func subHours(_ hours: Int) -> Date?{
        return self.changeTimeInterval(.hour, value: hours, modyfer: -1)
    }
    
    public func addMinutes(_ minutes: Int) -> Date?{
        return self.changeTimeInterval(.minute, value: minutes, modyfer: 1)
    }
    
    public func subMinutes(_ minutes: Int) -> Date?{
        return self.changeTimeInterval(.minute, value: minutes, modyfer: -1)
    }
    
    public func addSeconds(_ seconds: Int) -> Date?{
        return self.changeTimeInterval(.second, value: seconds, modyfer: 1)
    }
    
    public func subSeconds(_ seconds: Int) -> Date?{
        return self.changeTimeInterval(.second, value: seconds, modyfer: -1)
    }
    
    
    /*  DIFFERENCES */
    
    public func diffInYears(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let years = (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: self, to: fromDate, options: []).year
        return absoluteValue ? abs(years!) : years!
    }

    public func diffInMonths(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let months = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: self, to: fromDate, options: []).month
        return absoluteValue ? abs(months!) : months!
    }
    
    public func diffInWeeks(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let days = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self, to: fromDate, options: []).day
        let weeks = days!/7
        return absoluteValue ? abs(weeks) : weeks
    }
    
    public func diffInDays(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let days = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self, to: fromDate, options: []).day
        return absoluteValue ? abs(days!) : days!
    }
    
    public func diffInHours(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let hours = (Calendar.current as NSCalendar).components(NSCalendar.Unit.hour, from: self, to: fromDate, options: []).hour
        return absoluteValue ? abs(hours!) : hours!
    }
    
    public func diffInMinutes(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let minutes = (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: self, to: fromDate, options: []).minute
        return absoluteValue ? abs(minutes!) : minutes!
    }
    
    public func diffInSeconds(_ fromDate: Date, absoluteValue: Bool = true) -> Int{
        let seconds = (Calendar.current as NSCalendar).components(NSCalendar.Unit.second, from: self, to: fromDate, options: []).second
        return absoluteValue ? abs(seconds!) : seconds!
    }
    
    /* MODIFIERS */
    
    public func startOfDay() -> Date{
        return Calendar.current.startOfDay(for: self)
    }
    
    public func endOfDay() -> Date{
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = (Calendar.current as NSCalendar).date(byAdding: components, to: self.startOfDay(), options: [])
        return endOfDay!
    }
    
    public func startOfMonth() -> Date{
        return Date.NSDateFromYear(self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)!
    }
    
    public func endOfMonth() -> Date{
        return Date.NSDateFromYear(self.year, month: self.month, day: self.dayInMonth, hour: 23, minute: 59, second: 59)!
    }
    
    public func startOfYear() -> Date{
        return Date.NSDateFromYear(self.year, month: 1, day: 1, hour: 0, minute: 0, second: 0)!
    }
    
    public func endOfYear() -> Date{
        return Date.NSDateFromYear(self.year, month: 12, day: 31, hour: 23, minute: 59, second: 59)!
    }
    
    public func next() -> Date{
        return self.addDays(1)!
    }
    
    public func previous() -> Date{
        return self.subDays(1)!
    }
    
    public func average(_ date: Date) -> Date
    {
        let seconds = self.diffInSeconds(date, absoluteValue: false) / 2
        return self.addSeconds(seconds)!
    }
}

//public func ==(left: Date, right: Date) -> Bool {
//    return left.compare(right) == ComparisonResult.orderedSame
//}

//public func !=(left: Date, right: Date) -> Bool {
//    return !(left == right)
//}
//
//public func <(left: Date, right: Date) -> Bool {
//    return left.compare(right) == ComparisonResult.orderedAscending
//}
//
//public func >(left: Date, right: Date) -> Bool {
//    return left.compare(right) == ComparisonResult.orderedDescending
//}
//
//public func <=(left: Date, right: Date) -> Bool {
//    return (left < right) || (left == right)
//}
//
//public func >=(left: Date, right: Date) -> Bool {
//    return (left > right) || (left == right)
//}
