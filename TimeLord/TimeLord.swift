//
//  TimeLord.swift
//  TestProject
//
//  Created by Евгений Елчев on 04.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

import Foundation


public struct TimeLord : Hashable, Equatable, Comparable {
    
    fileprivate var nsDate: Date
    public var rawDate: Date{
        get{
            return self.nsDate
        }
    }
    
    public static let toStringFormat = "yyyy-MM-dd HH:mm:ss"
    public var defaultTimeZone: TimeZone = TimeZone.current
    
    public var hashValue : Int{
        get{
            return self.nsDate.hashValue
        }
    }
    
    public var era: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.era!
        }
    }
    public var year: Int
        {
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.year!
        }
    }
    public var month: Int
        {
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.month!
        }
    }
    public var day: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.day!
        }
    }
    public var dayInMonth: Int{
        get{
            return (Calendar.current as NSCalendar).range(of: .day, in: .month, for: self.rawDate).length
        }
    }
    public var hour: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.hour!
        }
    }
    public var minute: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.minute!
        }
    }
    public var second: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.second!
        }
    }
    public var nanosecond: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.nanosecond!
        }
    }
    public var weekday: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
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
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.weekdayOrdinal!
        }
    }
    public var quarter: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.quarter!
        }
    }
    public var weekOfMonth: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.weekOfMonth!
        }
    }
    public var weekOfYear: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.weekOfYear!
        }
    }
    public var yearForWeekOfYear: Int{
        get{
            let dateComponents = (Calendar.current as NSCalendar).components(NSCalendar.Unit(rawValue: UInt.max), from: self.rawDate)
            return dateComponents.yearForWeekOfYear!
        }
    }

    public init(
        year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int,
        second: Int,
        timeZone: TimeZone? = nil
    ){
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        
        if let timeZone = timeZone{
            self.defaultTimeZone = timeZone
            (dateComponents as NSDateComponents).timeZone = timeZone
        }
        dateComponents.timeZone = timeZone

        self.nsDate = Calendar.current.date(from: dateComponents)!
    }
    
    public init?(date: String, inFormat: String? = nil, timeZone: TimeZone? = nil){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = inFormat ?? TimeLord.toStringFormat
        if let timeZone = timeZone {
            self.defaultTimeZone = timeZone
            dateFormater.timeZone = timeZone
        }
        
        guard let nsDate = dateFormater.date(from: date) else{
            return nil
        }
        self.nsDate = nsDate
    }
    
    public init(date: Date, timeZone: TimeZone? = nil){
        self.nsDate = date
        if let timeZone = timeZone{
            self.defaultTimeZone = timeZone
        }
    }
    
    public init(timeIntervalSince1970: Double){
        self.nsDate = Date(timeIntervalSince1970: TimeInterval(timeIntervalSince1970))
    }
    
    public init(timeIntervalSinceNow: Double){
        self.nsDate = Date(timeIntervalSinceNow: TimeInterval(timeIntervalSinceNow))
    }
    
    public init(timeInterval: Double,  sinceDate: Date){
        self.nsDate = Date(timeInterval: timeInterval, since: sinceDate)
    }
    
    
    public init(timeIntervalSinceReferenceDate: TimeInterval){
        self.nsDate = Date(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate)
    }

    
    public init(keyWord: DateKeyWord){
        switch keyWord {
        case .now:
            self.nsDate = Date()
        case .today:
            self.nsDate = TimeLord(keyWord: .now).startOfDay().rawDate
        case .tomorrow:
            self.nsDate = TimeLord(keyWord: .today).addDays(1)!.rawDate
        case .yesterday:
            self.nsDate = TimeLord(keyWord: .today).subDays(1)!.rawDate
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
        }else{
            dateformater.timeZone = self.defaultTimeZone
        }
        
        return dateformater.string(from: self.nsDate)
    }
    
    public func toString(_ inTimeZone: TimeZone? = nil) -> String{
        return self.toStringInFormat(TimeLord.toStringFormat, inTimeZone: inTimeZone)
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
    
    
    
    public func between (_ first: TimeLord, second: TimeLord) -> Bool{
        return (first < self) && (self < second )
    }
    
    public func closest(_ first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) < self.diffInSeconds(second)  ? first : second
    }
    
    public func farthest(_ first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) > self.diffInSeconds(second)  ? first : second
    }
    
    public func earlier(_ date: TimeLord) -> TimeLord{
        return TimeLord(date: (self.rawDate as NSDate).earlierDate(date.rawDate))
    }
    
    public func later(_ date: TimeLord) -> TimeLord{
        return TimeLord(date: (self.rawDate as NSDate).laterDate(date.rawDate))
    }
    
    public func isWeekend() -> Bool{
        return Calendar.current.isDateInWeekend(self.rawDate)
    }
    
    public func isYesterday() -> Bool{
        return Calendar.current.isDateInYesterday(self.rawDate)
    }
    
    public func isToday() -> Bool{
        return Calendar.current.isDateInToday(self.rawDate)
    }
    
    public func isTomorrow() -> Bool{
        return Calendar.current.isDateInTomorrow(self.rawDate)
    }
    
    public func isFuture() -> Bool{
        return self > TimeLord(keyWord: .now)
    }
    
    public func isPast() -> Bool{
        return self < TimeLord(keyWord: .now)
    }
    
    public func isLeapYear() -> Bool{
        return (( self.year%100 != 0) && (self.year%4 == 0)) || (self.year%400 == 0);
    }
    
    public func isSameDay(_ date: TimeLord) -> Bool{
        return Calendar.current.isDate(self.rawDate, inSameDayAs: date.rawDate)
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
    
    fileprivate func changeTimeInterval(_ timeInterval: DateUnit, value: Int, modyfer: Int) -> TimeLord? {
        
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
        guard let newDate = (calendar as NSCalendar).date(byAdding: dateComponent, to: self.rawDate, options: .matchFirst) else{
            return nil
        }
        return TimeLord(date: newDate)
    }
    
    public func addYears(_ years: Int) -> TimeLord?{
        return self.changeTimeInterval(.year, value: years, modyfer: 1)
    }
    
    public func subYears(_ years: Int) -> TimeLord?{
        return self.changeTimeInterval(.year, value: years, modyfer: -1)
    }
    
    public func addMonths(_ months: Int) -> TimeLord?{
        return self.changeTimeInterval(.month, value: months, modyfer: 1)
    }
    
    public func subMonths(_ months: Int) -> TimeLord?{
        return self.changeTimeInterval(.month, value: months, modyfer: -1)
    }
    
    public func addDays(_ days: Int) -> TimeLord?{
        return self.changeTimeInterval(.day, value: days, modyfer: 1)
    }
    
    public func subDays(_ days: Int) -> TimeLord?{
        return self.changeTimeInterval(.day, value: days, modyfer: -1)
    }
    
    public func addHours(_ hours: Int) -> TimeLord?{
        return self.changeTimeInterval(.hour, value: hours, modyfer: 1)
    }
    
    public func subHours(_ hours: Int) -> TimeLord?{
        return self.changeTimeInterval(.hour, value: hours, modyfer: -1)
    }
    
    public func addMinutes(_ minutes: Int) -> TimeLord?{
        return self.changeTimeInterval(.minute, value: minutes, modyfer: 1)
    }
    
    public func subMinutes(_ minutes: Int) -> TimeLord?{
        return self.changeTimeInterval(.minute, value: minutes, modyfer: -1)
    }
    
    public func addSeconds(_ seconds: Int) -> TimeLord?{
        return self.changeTimeInterval(.second, value: seconds, modyfer: 1)
    }
    
    public func subSeconds(_ seconds: Int) -> TimeLord?{
        return self.changeTimeInterval(.second, value: seconds, modyfer: -1)
    }
    
    
    /*  DIFFERENCES */
    
    public func diffInYears(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let years = (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: self.rawDate, to: fromDate.rawDate, options: []).year
        return absoluteValue ? abs(years!) : years!
    }

    public func diffInMonths(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let months = (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: self.rawDate, to: fromDate.rawDate, options: []).month
        return absoluteValue ? abs(months!) : months!
    }
    
    public func diffInWeeks(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self.rawDate, to: fromDate.rawDate, options: []).day
        let weeks = days!/7
        return absoluteValue ? abs(weeks) : weeks
    }
    
    public func diffInDays(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self.rawDate, to: fromDate.rawDate, options: []).day
        return absoluteValue ? abs(days!) : days!
    }
    
    public func diffInHours(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let hours = (Calendar.current as NSCalendar).components(NSCalendar.Unit.hour, from: self.rawDate, to: fromDate.rawDate, options: []).hour
        return absoluteValue ? abs(hours!) : hours!
    }
    
    public func diffInMinutes(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let minutes = (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: self.rawDate, to: fromDate.rawDate, options: []).minute
        return absoluteValue ? abs(minutes!) : minutes!
    }
    
    public func diffInSeconds(_ fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let seconds = (Calendar.current as NSCalendar).components(NSCalendar.Unit.second, from: self.rawDate, to: fromDate.rawDate, options: []).second
        return absoluteValue ? abs(seconds!) : seconds!
    }
    
    /* MODIFIERS */
    
    public func inTimeZone(_ timeZone: TimeZone) -> TimeLord{
        return TimeLord(date: self.rawDate, timeZone: timeZone)
    }
    
    public func startOfDay() -> TimeLord{
        return TimeLord(date: Calendar.current.startOfDay(for: self.rawDate))
    }
    
    public func endOfDay() -> TimeLord{
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = (Calendar.current as NSCalendar).date(byAdding: components, to: self.startOfDay().rawDate, options: [])
        return TimeLord(date: endOfDay!)
    }
    
    public func startOfMonth() -> TimeLord{
        return TimeLord(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
    }
    
    public func endOfMonth() -> TimeLord{
        return TimeLord(year: self.year, month: self.month, day: self.dayInMonth, hour: 23, minute: 59, second: 59)
    }
    
    public func startOfYear() -> TimeLord{
        return TimeLord(year: self.year, month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
    
    public func endOfYear() -> TimeLord{
        return TimeLord(year: self.year, month: 12, day: 31, hour: 23, minute: 59, second: 59)
    }
    
    public func next() -> TimeLord{
        return self.addDays(1)!
    }
    
    public func previous() -> TimeLord{
        return self.subDays(1)!
    }
    
    public func average(_ date: TimeLord) -> TimeLord
    {
        let seconds = self.diffInSeconds(date, absoluteValue: false) / 2
        return self.addSeconds(seconds)!
    }
}

public func ==(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == ComparisonResult.orderedSame
}

public func !=(left: TimeLord, right: TimeLord) -> Bool {
    return !(left == right)
}

public func <(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == ComparisonResult.orderedAscending
}

public func >(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == ComparisonResult.orderedDescending
}

public func <=(left: TimeLord, right: TimeLord) -> Bool {
    return (left < right) || (left == right)
}

public func >=(left: TimeLord, right: TimeLord) -> Bool {
    return (left > right) || (left == right)
}
