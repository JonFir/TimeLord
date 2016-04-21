//
//  TimeLord.swift
//  TestProject
//
//  Created by Евгений Елчев on 04.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

import Foundation


extension NSDate {
    
    public static var toStringFormat: String{
       return "yyyy-MM-dd HH:mm:ss"
    }
    
    public var era: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.era
        }
    }
    public var year: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.year
        }
    }
    public var month: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.month
        }
    }
    public var day: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.day
        }
    }
    public var dayInMonth: Int{
        get{
            return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
        }
    }
    public var hour: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.hour
        }
    }
    public var minute: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.minute
        }
    }
    public var second: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.second
        }
    }
    public var nanosecond: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.nanosecond
        }
    }
    public var weekday: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
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
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.weekdayOrdinal
        }
    }
    public var quarter: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.quarter
        }
    }
    public var weekOfMonth: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.weekOfMonth
        }
    }
    public var weekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.weekOfYear
        }
    }
    public var yearForWeekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self)
            return dateComponents.yearForWeekOfYear
        }
    }

    public static func NSDateFromYear(
        year: Int,
        month: Int,
        day: Int,
        hour: Int,
        minute: Int,
        second: Int,
        timeZone: NSTimeZone? = nil
    ) -> NSDate?
    {
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        if let timeZone = timeZone{
            dateComponents.timeZone = timeZone
        }

        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)
    }
    
    public static func NSDateFromString(date: String, inFormat: String? = nil, timeZone: NSTimeZone? = nil) -> NSDate? {
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = inFormat ?? self.toStringFormat
        
        if let timeZone = timeZone {
            dateFormater.timeZone = timeZone
        }
        
        return dateFormater.dateFromString(date)
    }

    
    public static func NSDateAtKeyWord(keyWord: DateKeyWord) -> NSDate{
        switch keyWord {
        case .Now:
            return NSDate()
        case .Today:
            return NSDate.NSDateAtKeyWord(.Now).startOfDay()
        case .Tomorrow:
            return NSDate.NSDateAtKeyWord(.Today).addDays(1)!
        case .Yesterday:
            return NSDate.NSDateAtKeyWord(.Today).subDays(1)!
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
        }
        
        return dateformater.stringFromDate(self)
    }
    
    public func toString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat(NSDate.toStringFormat, inTimeZone: inTimeZone)
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
    
    
    
    public func between (first: NSDate, second: NSDate) -> Bool{
        return (first < self) && (self < second )
    }
    
    public func closest(first: NSDate, second: NSDate) -> NSDate{
        return self.diffInSeconds(first) < self.diffInSeconds(second)  ? first : second
    }
    
    public func farthest(first: NSDate, second: NSDate) -> NSDate{
        return self.diffInSeconds(first) > self.diffInSeconds(second)  ? first : second
    }
    
    public func earlier(date: NSDate) -> NSDate{
        return self.earlierDate(date)
    }
    
    public func later(date: NSDate) -> NSDate{
        return self.laterDate(date)
    }
    
    public func isWeekend() -> Bool{
        return NSCalendar.currentCalendar().isDateInWeekend(self)
    }
    
    public func isYesterday() -> Bool{
        return NSCalendar.currentCalendar().isDateInYesterday(self)
    }
    
    public func isToday() -> Bool{
        return NSCalendar.currentCalendar().isDateInToday(self)
    }
    
    public func isTomorrow() -> Bool{
        return NSCalendar.currentCalendar().isDateInTomorrow(self)
    }
    
    public func isFuture() -> Bool{
        return self > NSDate.NSDateAtKeyWord(.Now)
    }
    
    public func isPast() -> Bool{
        return self < NSDate.NSDateAtKeyWord(.Now)
    }
    
    public func isLeapYear() -> Bool{
        return (( self.year%100 != 0) && (self.year%4 == 0)) || (self.year%400 == 0);
    }
    
    public func isSameDay(date: NSDate) -> Bool{
        return NSCalendar.currentCalendar().isDate(self, inSameDayAsDate: date)
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
    
    private func changeTimeInterval(timeInterval: DateUnit, value: Int, modyfer: Int) -> NSDate? {
        
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
        
        return calendar.dateByAddingComponents(dateComponent, toDate: self, options: .MatchFirst)
    }
    
    public func addYears(years: Int) -> NSDate?{
        return self.changeTimeInterval(.Year, value: years, modyfer: 1)
    }
    
    public func subYears(years: Int) -> NSDate?{
        return self.changeTimeInterval(.Year, value: years, modyfer: -1)
    }
    
    public func addMonths(months: Int) -> NSDate?{
        return self.changeTimeInterval(.Month, value: months, modyfer: 1)
    }
    
    public func subMonths(months: Int) -> NSDate?{
        return self.changeTimeInterval(.Month, value: months, modyfer: -1)
    }
    
    public func addDays(days: Int) -> NSDate?{
        return self.changeTimeInterval(.Day, value: days, modyfer: 1)
    }
    
    public func subDays(days: Int) -> NSDate?{
        return self.changeTimeInterval(.Day, value: days, modyfer: -1)
    }
    
    public func addHours(hours: Int) -> NSDate?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: 1)
    }
    
    public func subHours(hours: Int) -> NSDate?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: -1)
    }
    
    public func addMinutes(minutes: Int) -> NSDate?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: 1)
    }
    
    public func subMinutes(minutes: Int) -> NSDate?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: -1)
    }
    
    public func addSeconds(seconds: Int) -> NSDate?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: 1)
    }
    
    public func subSeconds(seconds: Int) -> NSDate?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: -1)
    }
    
    
    /*  DIFFERENCES */
    
    public func diffInYears(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let years = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self, toDate: fromDate, options: []).year
        return absoluteValue ? abs(years) : years
    }

    public func diffInMonths(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let months = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self, toDate: fromDate, options: []).month
        return absoluteValue ? abs(months) : months
    }
    
    public func diffInWeeks(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self, toDate: fromDate, options: []).day
        let weeks = days/7
        return absoluteValue ? abs(weeks) : weeks
    }
    
    public func diffInDays(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self, toDate: fromDate, options: []).day
        return absoluteValue ? abs(days) : days
    }
    
    public func diffInHours(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let hours = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self, toDate: fromDate, options: []).hour
        return absoluteValue ? abs(hours) : hours
    }
    
    public func diffInMinutes(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let minutes = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: self, toDate: fromDate, options: []).minute
        return absoluteValue ? abs(minutes) : minutes
    }
    
    public func diffInSeconds(fromDate: NSDate, absoluteValue: Bool = true) -> Int{
        let seconds = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: self, toDate: fromDate, options: []).second
        return absoluteValue ? abs(seconds) : seconds
    }
    
    /* MODIFIERS */
    
    public func startOfDay() -> NSDate{
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    public func endOfDay() -> NSDate{
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startOfDay(), options: [])
        return endOfDay!
    }
    
    public func startOfMonth() -> NSDate{
        return NSDate.NSDateFromYear(self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)!
    }
    
    public func endOfMonth() -> NSDate{
        return NSDate.NSDateFromYear(self.year, month: self.month, day: self.dayInMonth, hour: 23, minute: 59, second: 59)!
    }
    
    public func startOfYear() -> NSDate{
        return NSDate.NSDateFromYear(self.year, month: 1, day: 1, hour: 0, minute: 0, second: 0)!
    }
    
    public func endOfYear() -> NSDate{
        return NSDate.NSDateFromYear(self.year, month: 12, day: 31, hour: 23, minute: 59, second: 59)!
    }
    
    public func next() -> NSDate{
        return self.addDays(1)!
    }
    
    public func previous() -> NSDate{
        return self.subDays(1)!
    }
    
    public func average(date: NSDate) -> NSDate
    {
        let seconds = self.diffInSeconds(date, absoluteValue: false) / 2
        return self.addSeconds(seconds)!
    }
}

public func ==(left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedSame
}

public func !=(left: NSDate, right: NSDate) -> Bool {
    return !(left == right)
}

public func <(left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedAscending
}

public func >(left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedDescending
}

public func <=(left: NSDate, right: NSDate) -> Bool {
    return (left < right) || (left == right)
}

public func >=(left: NSDate, right: NSDate) -> Bool {
    return (left > right) || (left == right)
}