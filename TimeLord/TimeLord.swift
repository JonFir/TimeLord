//
//  TimeLord.swift
//  TestProject
//
//  Created by Евгений Елчев on 04.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

import Foundation


public struct TimeLord : Hashable, Equatable, Comparable {
    
    private var nsDate: NSDate
    public var rawDate: NSDate{
        get{
            return self.nsDate
        }
    }
    
    public static let toStringFormat = "yyyy-MM-dd HH:mm:ss"
    public var defaultTimeZone: NSTimeZone = NSTimeZone.systemTimeZone()
    
    public var hashValue : Int{
        get{
            return self.nsDate.hashValue
        }
    }
    
    public var era: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.era
        }
    }
    public var year: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.year
        }
    }
    public var month: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.month
        }
    }
    public var day: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.day
        }
    }
    public var dayInMonth: Int{
        get{
            return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self.rawDate).length
        }
    }
    public var hour: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.hour
        }
    }
    public var minute: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.minute
        }
    }
    public var second: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.second
        }
    }
    public var nanosecond: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.nanosecond
        }
    }
    public var weekday: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekday
        }
    }
    public var weekdaySymbol: String{
        get{
            return NSCalendar.currentCalendar().weekdaySymbols[self.weekday - 1]
        }
    }
    public var weekdayOrdinal: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekdayOrdinal
        }
    }
    public var quarter: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.quarter
        }
    }
    public var weekOfMonth: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekOfMonth
        }
    }
    public var weekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekOfYear
        }
    }
    public var yearForWeekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.yearForWeekOfYear
        }
    }

    public init(
        year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int,
        second: Int,
        timeZone: NSTimeZone? = nil
    ){
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        if let timeZone = timeZone{
            self.defaultTimeZone = timeZone
            dateComponents.timeZone = timeZone
        }

        self.nsDate = NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
    }
    
    public init?(date: String, inFormat: String? = nil, timeZone: NSTimeZone? = nil){
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = inFormat ?? TimeLord.toStringFormat
        if let timeZone = timeZone {
            self.defaultTimeZone = timeZone
            dateFormater.timeZone = timeZone
        }
        
        guard let nsDate = dateFormater.dateFromString(date) else{
            return nil
        }
        self.nsDate = nsDate
    }
    
    public init(date: NSDate, timeZone: NSTimeZone? = nil){
        self.nsDate = date
        if let timeZone = timeZone{
            self.defaultTimeZone = timeZone
        }
    }
    
    public init(timeIntervalSince1970: Double){
        self.nsDate = NSDate(timeIntervalSince1970: NSTimeInterval(timeIntervalSince1970))
    }
    
    public init(timeIntervalSinceNow: Double){
        self.nsDate = NSDate(timeIntervalSinceNow: NSTimeInterval(timeIntervalSinceNow))
    }
    
    public init(timeInterval: Double,  sinceDate: NSDate){
        self.nsDate = NSDate(timeInterval: timeInterval, sinceDate: sinceDate)
    }
    
    
    public init(timeIntervalSinceReferenceDate: NSTimeInterval){
        self.nsDate = NSDate(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate)
    }

    
    public init(keyWord: DateKeyWord){
        switch keyWord {
        case .Now:
            self.nsDate = NSDate()
        case .Today:
            self.nsDate = TimeLord(keyWord: .Now).startOfDay().rawDate
        case .Tomorrow:
            self.nsDate = TimeLord(keyWord: .Today).addDays(1)!.rawDate
        case .Yesterday:
            self.nsDate = TimeLord(keyWord: .Today).subDays(1)!.rawDate
        }
    }
    
    public enum DateUnit{
        case Era
        case Year
        case Month
        case Day
        case Hour
        case Minute
        case Second
        case Nanosecond
        case Weekday
        case WeekdayOrdinal
        case Quarter
        case WeekOfMonth
        case WeekOfYear
        case YearForWeekOfYear
    }
    
    public enum DateKeyWord{
        case Now
        case Today
        case Tomorrow
        case Yesterday
    }
    
    public func toStringInFormat(format: String, inTimeZone: NSTimeZone? = nil) -> String{
        let dateformater = NSDateFormatter()
        dateformater.dateFormat = format
        
        if let timeZone = inTimeZone {
            dateformater.timeZone = timeZone
        }else{
            dateformater.timeZone = self.defaultTimeZone
        }
        
        return dateformater.stringFromDate(self.nsDate)
    }
    
    public func toString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat(TimeLord.toStringFormat, inTimeZone: inTimeZone)
    }
    
    public func toFormattedDateString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("MMM d, YYYY", inTimeZone: inTimeZone)
    }
    
    public func toTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    public func toDateTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    public func toDayDateTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("E, MMM d, YYYY h:mm a", inTimeZone: inTimeZone)
    }
    
    public func toIso8601String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc850String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    public func toRfc1123String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc2822String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc3339String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRssString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toW3cString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc1036String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toRfc822String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    public func toAtomString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    public func toCookieString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yyyy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    /* COMPARISONS */
    
    
    
    public func between (first: TimeLord, second: TimeLord) -> Bool{
        return (first < self) && (self < second )
    }
    
    public func closest(first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) < self.diffInSeconds(second)  ? first : second
    }
    
    public func farthest(first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) > self.diffInSeconds(second)  ? first : second
    }
    
    public func earlier(date: TimeLord) -> TimeLord{
        return TimeLord(date: self.rawDate.earlierDate(date.rawDate))
    }
    
    public func later(date: TimeLord) -> TimeLord{
        return TimeLord(date: self.rawDate.laterDate(date.rawDate))
    }
    
    public func isWeekend() -> Bool{
        return NSCalendar.currentCalendar().isDateInWeekend(self.rawDate)
    }
    
    public func isYesterday() -> Bool{
        return NSCalendar.currentCalendar().isDateInYesterday(self.rawDate)
    }
    
    public func isToday() -> Bool{
        return NSCalendar.currentCalendar().isDateInToday(self.rawDate)
    }
    
    public func isTomorrow() -> Bool{
        return NSCalendar.currentCalendar().isDateInTomorrow(self.rawDate)
    }
    
    public func isFuture() -> Bool{
        return self > TimeLord(keyWord: .Now)
    }
    
    public func isPast() -> Bool{
        return self < TimeLord(keyWord: .Now)
    }
    
    public func isLeapYear() -> Bool{
        return (( self.year%100 != 0) && (self.year%4 == 0)) || (self.year%400 == 0);
    }
    
    public func isSameDay(date: TimeLord) -> Bool{
        return NSCalendar.currentCalendar().isDate(self.rawDate, inSameDayAsDate: date.rawDate)
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
    
    private func changeTimeInterval(timeInterval: DateUnit, value: Int, modyfer: Int) -> TimeLord? {
        
        let modyfedValue = value * modyfer
        
        let dateComponent = NSDateComponents()
        
        switch timeInterval {
        case .Second:
            dateComponent.second = modyfedValue
        case .Minute:
            dateComponent.minute = modyfedValue
        case .Hour:
            dateComponent.hour = modyfedValue
        case .Day:
            dateComponent.day = modyfedValue
        case .WeekOfMonth:
            dateComponent.day = modyfedValue * 7
        case .Month:
            dateComponent.month = modyfedValue
        case .Year:
            dateComponent.year = modyfedValue
        default:
            return nil
        }
        
        let calendar = NSCalendar.currentCalendar()
        guard let newDate = calendar.dateByAddingComponents(dateComponent, toDate: self.rawDate, options: .MatchFirst) else{
            return nil
        }
        return TimeLord(date: newDate)
    }
    
    public func addYears(years: Int) -> TimeLord?{
        return self.changeTimeInterval(.Year, value: years, modyfer: 1)
    }
    
    public func subYears(years: Int) -> TimeLord?{
        return self.changeTimeInterval(.Year, value: years, modyfer: -1)
    }
    
    public func addMonths(months: Int) -> TimeLord?{
        return self.changeTimeInterval(.Month, value: months, modyfer: 1)
    }
    
    public func subMonths(months: Int) -> TimeLord?{
        return self.changeTimeInterval(.Month, value: months, modyfer: -1)
    }
    
    public func addDays(days: Int) -> TimeLord?{
        return self.changeTimeInterval(.Day, value: days, modyfer: 1)
    }
    
    public func subDays(days: Int) -> TimeLord?{
        return self.changeTimeInterval(.Day, value: days, modyfer: -1)
    }
    
    public func addHours(hours: Int) -> TimeLord?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: 1)
    }
    
    public func subHours(hours: Int) -> TimeLord?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: -1)
    }
    
    public func addMinutes(minutes: Int) -> TimeLord?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: 1)
    }
    
    public func subMinutes(minutes: Int) -> TimeLord?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: -1)
    }
    
    public func addSeconds(seconds: Int) -> TimeLord?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: 1)
    }
    
    public func subSeconds(seconds: Int) -> TimeLord?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: -1)
    }
    
    
    /*  DIFFERENCES */
    
    public func diffInYears(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let years = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).year
        return absoluteValue ? abs(years) : years
    }

    public func diffInMonths(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let months = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).month
        return absoluteValue ? abs(months) : months
    }
    
    public func diffInWeeks(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).day
        let weeks = days/7
        return absoluteValue ? abs(weeks) : weeks
    }
    
    public func diffInDays(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).day
        return absoluteValue ? abs(days) : days
    }
    
    public func diffInHours(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let hours = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).hour
        return absoluteValue ? abs(hours) : hours
    }
    
    public func diffInMinutes(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let minutes = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).minute
        return absoluteValue ? abs(minutes) : minutes
    }
    
    public func diffInSeconds(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let seconds = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).second
        return absoluteValue ? abs(seconds) : seconds
    }
    
    /* MODIFIERS */
    
    public func inTimeZone(timeZone: NSTimeZone) -> TimeLord{
        return TimeLord(date: self.rawDate, timeZone: timeZone)
    }
    
    public func startOfDay() -> TimeLord{
        return TimeLord(date: NSCalendar.currentCalendar().startOfDayForDate(self.rawDate))
    }
    
    public func endOfDay() -> TimeLord{
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startOfDay().rawDate, options: [])
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
    
    public func average(date: TimeLord) -> TimeLord
    {
        let seconds = self.diffInSeconds(date, absoluteValue: false) / 2
        return self.addSeconds(seconds)!
    }
}

public func ==(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedSame
}

public func !=(left: TimeLord, right: TimeLord) -> Bool {
    return !(left == right)
}

public func <(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedAscending
}

public func >(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedDescending
}

public func <=(left: TimeLord, right: TimeLord) -> Bool {
    return (left < right) || (left == right)
}

public func >=(left: TimeLord, right: TimeLord) -> Bool {
    return (left > right) || (left == right)
}