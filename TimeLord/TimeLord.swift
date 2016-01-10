//
//  TimeLord.swift
//  TestProject
//
//  Created by Евгений Елчев on 04.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

import Foundation


public struct TimeLord {
    
    private var nsDate: NSDate
    var rawDate: NSDate{
        get{
            return self.nsDate
        }
    }
    
    static let toStringFormat = "yyyy-MM-dd HH:mm:ss"
    var defaultTimeZone: NSTimeZone = NSTimeZone.systemTimeZone()
    
    var era: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.era
        }
    }
    var year: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.year
        }
    }
    var month: Int
        {
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.month
        }
    }
    var day: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.day
        }
    }
    var dayInMonth: Int{
        get{
            return NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self.rawDate).length
        }
    }
    var hour: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.hour
        }
    }
    var minute: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.minute
        }
    }
    var second: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.second
        }
    }
    var nanosecond: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.nanosecond
        }
    }
    var weekday: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekday
        }
    }
    var weekdaySymbol: String{
        get{
            return NSCalendar.currentCalendar().weekdaySymbols[self.weekday - 1]
        }
    }
    var weekdayOrdinal: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekdayOrdinal
        }
    }
    var quarter: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.quarter
        }
    }
    var weekOfMonth: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekOfMonth
        }
    }
    var weekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.weekOfYear
        }
    }
    var yearForWeekOfYear: Int{
        get{
            let dateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit(rawValue: UInt.max), fromDate: self.rawDate)
            return dateComponents.yearForWeekOfYear
        }
    }

    init(
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
    
    init?(date: String, inFormat: String? = nil, timeZone: NSTimeZone? = nil){
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
    
    init(date: NSDate, timeZone: NSTimeZone? = nil){
        self.nsDate = date
        if let timeZone = timeZone{
            self.defaultTimeZone = timeZone
        }
    }
    
    init(timeIntervalSince1970: Double){
        self.nsDate = NSDate(timeIntervalSince1970: NSTimeInterval(timeIntervalSince1970))
    }
    
    init(timeIntervalSinceNow: Double){
        self.nsDate = NSDate(timeIntervalSinceNow: NSTimeInterval(timeIntervalSinceNow))
    }
    
    init(timeInterval: Double,  sinceDate: NSDate){
        self.nsDate = NSDate(timeInterval: timeInterval, sinceDate: sinceDate)
    }
    
    
    init(timeIntervalSinceReferenceDate: NSTimeInterval){
        self.nsDate = NSDate(timeIntervalSinceReferenceDate: timeIntervalSinceReferenceDate)
    }

    
    init(keyWord: DateKeyWord){
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
    
    enum DateUnit{
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
    
    enum DateKeyWord{
        case Now
        case Today
        case Tomorrow
        case Yesterday
    }
    
    func toStringInFormat(format: String, inTimeZone: NSTimeZone? = nil) -> String{
        let dateformater = NSDateFormatter()
        dateformater.dateFormat = format
        
        if let timeZone = inTimeZone {
            dateformater.timeZone = timeZone
        }else{
            dateformater.timeZone = self.defaultTimeZone
        }
        
        return dateformater.stringFromDate(self.nsDate)
    }
    
    func toString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat(TimeLord.toStringFormat, inTimeZone: inTimeZone)
    }
    
    func toFormattedDateString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("MMM d, YYYY", inTimeZone: inTimeZone)
    }
    
    func toTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    func toDateTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: inTimeZone)
    }
    
    func toDayDateTimeString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("E, MMM d, YYYY h:mm a", inTimeZone: inTimeZone)
    }
    
    func toIso8601String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZ", inTimeZone: inTimeZone)
    }
    
    func toRfc850String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    func toRfc1123String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    func toRfc2822String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    func toRfc3339String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    func toRssString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yyyy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    func toW3cString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    func toRfc1036String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    func toRfc822String(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEE',' dd MMM yy HH':'mm':'ss ZZZ", inTimeZone: inTimeZone)
    }
    
    func toAtomString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("yyyy-MM-dd'T'HH:mm:ssZZZZZ", inTimeZone: inTimeZone)
    }
    
    func toCookieString(inTimeZone: NSTimeZone? = nil) -> String{
        return self.toStringInFormat("EEEE',' dd'-'MMM'-'yyyy HH':'mm':'ss z", inTimeZone: inTimeZone)
    }
    
    /* COMPARISONS */
    
    
    
    func between (first: TimeLord, second: TimeLord) -> Bool{
        return (first < self) && (self < second )
    }
    
    func closest(first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) < self.diffInSeconds(second)  ? first : second
    }
    
    func farthest(first: TimeLord, second: TimeLord) -> TimeLord{
        return self.diffInSeconds(first) > self.diffInSeconds(second)  ? first : second
    }
    
    func earlier(date: TimeLord) -> TimeLord{
        return TimeLord(date: self.rawDate.earlierDate(date.rawDate))
    }
    
    func later(date: TimeLord) -> TimeLord{
        return TimeLord(date: self.rawDate.laterDate(date.rawDate))
    }
    
    func isWeekend() -> Bool{
        return NSCalendar.currentCalendar().isDateInWeekend(self.rawDate)
    }
    
    func isYesterday() -> Bool{
        return NSCalendar.currentCalendar().isDateInYesterday(self.rawDate)
    }
    
    func isToday() -> Bool{
        return NSCalendar.currentCalendar().isDateInToday(self.rawDate)
    }
    
    func isTomorrow() -> Bool{
        return NSCalendar.currentCalendar().isDateInTomorrow(self.rawDate)
    }
    
    func isFuture() -> Bool{
        return self > TimeLord(keyWord: .Now)
    }
    
    func isPast() -> Bool{
        return self < TimeLord(keyWord: .Now)
    }
    
    func isLeapYear() -> Bool{
        return (( self.year%100 != 0) && (self.year%4 == 0)) || (self.year%400 == 0);
    }
    
    func isSameDay(date: TimeLord) -> Bool{
        return NSCalendar.currentCalendar().isDate(self.rawDate, inSameDayAsDate: date.rawDate)
    }
    
    func isSunday() -> Bool{
        return self.weekday == 1
    }
    
    func isMonday() -> Bool{
        return self.weekday == 2
    }
    
    func isTuesday() -> Bool{
        return self.weekday == 3
    }
    
    func isWednesday() -> Bool{
        return self.weekday == 4
    }
    
    func isThursday() -> Bool{
        return self.weekday == 5
    }
    
    func isFriday() -> Bool{
        return self.weekday == 6
    }
    
    func isSaturday() -> Bool{
        return self.weekday == 7
    }
    
    /* ADDITIONS AND SUBTRACTION */
    
    private func changeTimeInterval(timeInterval: DateUnit, value: UInt, modyfer: Int) -> TimeLord? {
        
        let modyfedValue = Int(value) * modyfer
        
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
    
    func addYears(years: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Year, value: years, modyfer: 1)
    }
    
    func subYears(years: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Year, value: years, modyfer: -1)
    }
    
    func addMonths(months: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Month, value: months, modyfer: 1)
    }
    
    func subMonths(months: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Month, value: months, modyfer: -1)
    }
    
    func addDays(days: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Day, value: days, modyfer: 1)
    }
    
    func subDays(days: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Day, value: days, modyfer: -1)
    }
    
    func addHours(hours: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: 1)
    }
    
    func subHours(hours: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Hour, value: hours, modyfer: -1)
    }
    
    func addMinutes(minutes: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: 1)
    }
    
    func subMinutes(minutes: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Minute, value: minutes, modyfer: -1)
    }
    
    func addSeconds(seconds: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: 1)
    }
    
    func subSeconds(seconds: UInt) -> TimeLord?{
        return self.changeTimeInterval(.Second, value: seconds, modyfer: -1)
    }
    
    
    /*  DIFFERENCES */
    
    func diffInYears(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let years = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).year
        return absoluteValue ? abs(years) : years
    }

    func diffInMonths(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let months = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).month
        return absoluteValue ? abs(months) : months
    }
    
    func diffInWeeks(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).day
        let weeks = days/7
        return absoluteValue ? abs(weeks) : weeks
    }
    
    func diffInDays(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let days = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).day
        return absoluteValue ? abs(days) : days
    }
    
    func diffInHours(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let hours = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).hour
        return absoluteValue ? abs(hours) : hours
    }
    
    func diffInMinutes(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let minutes = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).minute
        return absoluteValue ? abs(minutes) : minutes
    }
    
    func diffInSeconds(fromDate: TimeLord, absoluteValue: Bool = true) -> Int{
        let seconds = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: self.rawDate, toDate: fromDate.rawDate, options: []).second
        return absoluteValue ? abs(seconds) : seconds
    }
    
    /* MODIFIERS */
    
    func inTimeZone(timeZone: NSTimeZone) -> TimeLord{
        return TimeLord(date: self.rawDate, timeZone: timeZone)
    }
    
    func startOfDay() -> TimeLord{
        return TimeLord(date: NSCalendar.currentCalendar().startOfDayForDate(self.rawDate))
    }
    
    func endOfDay() -> TimeLord{
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        let endOfDay = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self.startOfDay().rawDate, options: [])
        return TimeLord(date: endOfDay!)
    }
    
    func startOfMonth() -> TimeLord{
        return TimeLord(year: self.year, month: self.month, day: 1, hour: 0, minute: 0, second: 0)
    }
    
    func endOfMonth() -> TimeLord{
        return TimeLord(year: self.year, month: self.month, day: self.dayInMonth, hour: 23, minute: 59, second: 59)
    }
    
    func startOfYear() -> TimeLord{
        return TimeLord(year: self.year, month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
    
    func endOfYear() -> TimeLord{
        return TimeLord(year: self.year, month: 12, day: 31, hour: 23, minute: 59, second: 59)
    }
    
    func next() -> TimeLord{
        let nextDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: self.rawDate, options: [])!
        return TimeLord(date: NSCalendar.currentCalendar().startOfDayForDate(nextDate))
    }
    
    func previous() -> TimeLord{
        let nextDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: self.rawDate, options: [])!
        return TimeLord(date: NSCalendar.currentCalendar().startOfDayForDate(nextDate))
    }
    
    func average(date: TimeLord) -> TimeLord
    {
        let seconds = self.diffInSeconds(date, absoluteValue: false) / 2
        return seconds > 0 ? self.addSeconds(UInt(abs(seconds)))! : self.subSeconds(UInt(abs(seconds)))!
    }
}

func ==(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedSame
}

func !=(left: TimeLord, right: TimeLord) -> Bool {
    return !(left == right)
}

func <(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedAscending
}

func >(left: TimeLord, right: TimeLord) -> Bool {
    return left.rawDate.compare(right.rawDate) == NSComparisonResult.OrderedDescending
}

func <=(left: TimeLord, right: TimeLord) -> Bool {
    return (left < right) || (left == right)
}

func >=(left: TimeLord, right: TimeLord) -> Bool {
    return (left > right) || (left == right)
}