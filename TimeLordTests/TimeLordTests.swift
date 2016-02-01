//
//  TimeLordTests.swift
//  TimeLordTests
//
//  Created by Евгений Елчев on 08.01.16.
//  Copyright © 2016 Jon FIr. All rights reserved.
//

import XCTest
@testable import TimeLord

class TimeLordTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let fff = TimeLord(date: "sdfds", inFormat: "we")
        XCTAssertNil(fff, "")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDateUnitGetter(){
        let tmDateInDefaultFormat = TimeLord(date: "2016-01-08 13:38:00")
        XCTAssertEqual(tmDateInDefaultFormat?.year, 2016)
        XCTAssertEqual(tmDateInDefaultFormat?.month, 01)
        XCTAssertEqual(tmDateInDefaultFormat?.day, 08)
        XCTAssertEqual(tmDateInDefaultFormat?.hour, 13)
        XCTAssertEqual(tmDateInDefaultFormat?.minute, 38)
        XCTAssertEqual(tmDateInDefaultFormat?.second, 0)
        XCTAssertEqual(tmDateInDefaultFormat?.dayInMonth, 31)
        XCTAssertEqual(tmDateInDefaultFormat?.nanosecond, 0)
        XCTAssertEqual(tmDateInDefaultFormat?.weekday, 6)
        XCTAssertEqual(tmDateInDefaultFormat?.weekdaySymbol, "пятница")
        XCTAssertEqual(tmDateInDefaultFormat?.weekdayOrdinal, 2)
        XCTAssertEqual(tmDateInDefaultFormat?.quarter, 0)
        XCTAssertEqual(tmDateInDefaultFormat?.weekOfMonth, 2)
        XCTAssertEqual(tmDateInDefaultFormat?.weekOfYear, 2)
        XCTAssertEqual(tmDateInDefaultFormat?.yearForWeekOfYear, 2016)
        XCTAssertEqual(tmDateInDefaultFormat?.era, 1)
    }
    
    func testInitFromNSDate(){
        let nsDate = NSDate()
        let tmDate = TimeLord(date: nsDate)
        XCTAssertEqual(nsDate, tmDate.rawDate, "nsdate should equal")
        let dateformater = NSDateFormatter()
        dateformater.timeZone = NSTimeZone(abbreviation: "MSK")
        dateformater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let tmDateMSK = TimeLord(date: nsDate, timeZone: NSTimeZone(abbreviation: "MSK"))
        let nsDateMSK = dateformater.stringFromDate(nsDate)
        XCTAssertEqual(tmDateMSK.toString(), nsDateMSK, "nsdate should equal")
    }
    
    func testInitFromDateUnit(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 14, minute: 25, second: 00, timeZone: NSTimeZone(abbreviation: "KRAT"))
        XCTAssertEqual(tm1.toString(), "2016-01-08 14:25:00")
        
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00, timeZone: NSTimeZone(abbreviation: "MSK"))
        XCTAssertEqual(tm2.toString(), "2016-01-08 10:25:00")
        XCTAssertEqual(tm1.rawDate, tm2.rawDate)
        
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 14, minute: 25, second: 00)
        XCTAssertEqual(tm3.toString(), "2016-01-08 14:25:00")
        XCTAssertEqual(tm1.rawDate, tm3.rawDate)
    }
    
    func testInitFromString(){
        let dateformater = NSDateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateformater.dateFromString("2016-01-08 13:38:00")
        let tmDateInDefaultFormat = TimeLord(date: "2016-01-08 13:38:00")
        let tmDateInCustomFormat = TimeLord(date: "2016-01-08 13:38:00", inFormat: "yyyy-MM-dd HH:mm:ss")
        let tmDateInCustomFormatAndTimeZone = TimeLord(date: "2016-01-08 09:38:00", inFormat: "yyyy-MM-dd HH:mm:ss", timeZone: NSTimeZone(abbreviation: "MSK"))
        XCTAssertEqual(nsDate, tmDateInDefaultFormat!.rawDate, "date should equal")
        XCTAssertEqual(nsDate, tmDateInCustomFormat!.rawDate, "date should equal")
        XCTAssertEqual(nsDate, tmDateInCustomFormatAndTimeZone!.rawDate, "date should equal")
    }
    
    func testIniTimeIntervalSince1970(){
        let tm = TimeLord(timeIntervalSince1970: 1452243489)
        let ns = NSDate(timeIntervalSince1970: 1452243489)
        XCTAssertEqual(tm.rawDate, ns)
    }
    
    func testInitTimeIntervalSinceNow(){
        let tm = TimeLord(timeIntervalSinceNow: 1452243489)
        let ns = NSDate(timeIntervalSinceNow: 1452243489)
        let dateformater = NSDateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd HH:mm"
        let nsString = dateformater.stringFromDate(ns)
        let tmString = tm.toStringInFormat("yyyy-MM-dd HH:mm")
        XCTAssertEqual(nsString, tmString)
    }
    
    func testInitTimeIntervalSinceDate(){
        let date = NSDate()
        let tm = TimeLord(timeInterval: 1452243489, sinceDate: date)
        let ns = NSDate(timeInterval: 1452243489, sinceDate: date)
        XCTAssertEqual(tm.rawDate, ns)
    }
    
    func testInitTimeIntervalSinceReferenceDate(){
        let tm = TimeLord(timeIntervalSinceReferenceDate: 1452243489)
        let ns = NSDate(timeIntervalSinceReferenceDate: 1452243489)
        XCTAssertEqual(tm.rawDate, ns)
    }
    
    func testInitFormKeyWord(){
        let nsNow = NSDate()
        let tmNow = TimeLord(keyWord: .Now)
        let dateformater = NSDateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd HH:mm"
        let nsString = dateformater.stringFromDate(nsNow)
        let tmString = tmNow.toStringInFormat("yyyy-MM-dd HH:mm")
        XCTAssertEqual(nsString, tmString)
        
        
        let tmToday = TimeLord(keyWord: .Today)
        let nsToday = NSCalendar.currentCalendar().startOfDayForDate(NSDate())
        XCTAssertEqual(nsToday, tmToday.rawDate)
        
        let tmTomorrow = TimeLord(keyWord: .Tomorrow)
        let nsTomorrow = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: nsToday, options: [])
        XCTAssertEqual(nsTomorrow, tmTomorrow.rawDate)
        
        let tmYesterday = TimeLord(keyWord: .Yesterday)
        let nsYesterday = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: -1, toDate: nsToday, options: [])
        XCTAssertEqual(nsYesterday, tmYesterday.rawDate)
    }
    
    func testToString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm.toString(), "2016-01-08 23:00:00")
    }
    
    func testToStringInFormat(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm.toStringInFormat("yyyy-MM-dd HH:mm:ss"), "2016-01-08 23:00:00")
        XCTAssertEqual(tm.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: NSTimeZone(abbreviation: "MSK")), "2016-01-08 19:00:00")
    }
    
    func testToFormattedDateString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm.toFormattedDateString(), "янв. 8, 2016")
    }
    
    func testTimeString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toTimeString(), "23:25:40")
    }
    
    func testToDateTimeString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toDateTimeString(), "2016-01-08 23:25:40")
    }
    
    func testToDayDateTimeString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toDayDateTimeString(), "пт, янв. 8, 2016 11:25 PM")
    }
    
    func testToAtomString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toAtomString(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToCookieString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toCookieString(), "пятница, 08-янв.-2016 23:25:40 GMT+7")
    }
    
    func testToIso8601String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toIso8601String(), "2016-01-08T23:25:40+0700")
    }
    
    func testToRfc822String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc822String(), "пт, 08 янв. 16 23:25:40 +0700")
    }
    
    func testToRfc850String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc850String(), "пятница, 08-янв.-16 23:25:40 GMT+7")
    }
    
    func testToRfc1036String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc1036String(), "пт, 08 янв. 16 23:25:40 +0700")
    }
    
    func testToRfc1123String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc1123String(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testToRfc2822String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc2822String(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testToRfc3339String(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRfc3339String(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToW3cString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toW3cString(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToRssString(){
        let tm = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm.toRssString(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testBetween(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 20, minute: 25, second: 40)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 22, minute: 25, second: 40)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 24, minute: 25, second: 40)
        
        XCTAssertFalse(tm1.between(tm2, second: tm3))
        XCTAssertTrue(tm2.between(tm1, second: tm3))
    }
    
    func testClosest(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm1.closest(tm2, second: tm3).rawDate, tm2.rawDate)
        XCTAssertEqual(tm1.closest(tm3, second: tm2).rawDate, tm2.rawDate)
    }

    func testFarthest(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm1.farthest(tm2, second: tm3).rawDate, tm3.rawDate)
        XCTAssertEqual(tm1.farthest(tm3, second: tm2).rawDate, tm3.rawDate)
    }

    func testEarlier(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm2.earlier(tm1).rawDate, tm1.rawDate)
        XCTAssertEqual(tm2.earlier(tm3).rawDate, tm2.rawDate)
    }
    
    func testLater(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm2.later(tm1).rawDate, tm2.rawDate)
        XCTAssertEqual(tm2.later(tm3).rawDate, tm3.rawDate)
    }
    
    func testIsWeekend(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm2.isWeekend())
        XCTAssertFalse(tm1.isWeekend())
    }
    
    func testIsYesterday(){
        let nsYesterday = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
        let tmYesterday = TimeLord(date: nsYesterday!)
        let tmNow = TimeLord(keyWord: .Now)
        XCTAssertTrue(tmYesterday.isYesterday())
        XCTAssertFalse(tmNow.isYesterday())
    }
    
    func testIsToday(){
        let nsTommorow = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: NSDate(), options: [])
        let tmTommorow = TimeLord(date: nsTommorow!)
        let tmNow = TimeLord(keyWord: .Now)
        XCTAssertTrue(tmNow.isToday())
        XCTAssertFalse(tmTommorow.isToday())
    }
    
    func testIsTomorrow(){
        let nsTommorow = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: NSDate(), options: [])
        let tmTommorow = TimeLord(date: nsTommorow!)
        let tmNow = TimeLord(keyWord: .Now)
        XCTAssertTrue(tmTommorow.isTomorrow())
        XCTAssertFalse(tmNow.isTomorrow())
    }
    
    func testIsFuture(){
        let nsTommorow = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: NSDate(), options: [])
        let tmTommorow = TimeLord(date: nsTommorow!)
        
        let nsYesterday = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
        let tmYesterday = TimeLord(date: nsYesterday!)
        
        XCTAssertTrue(tmTommorow.isFuture())
        XCTAssertFalse(tmYesterday.isFuture())
    }
    
    func testIsPast(){
        let nsTommorow = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: NSDate(), options: [])
        let tmTommorow = TimeLord(date: nsTommorow!)
        
        let nsYesterday = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
        let tmYesterday = TimeLord(date: nsYesterday!)
        
        XCTAssertFalse(tmTommorow.isPast())
        XCTAssertTrue(tmYesterday.isPast())
    }
    
    func testIsLeapYear(){
        let leapYear = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let notLeapYear = TimeLord(year: 2015, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(leapYear.isLeapYear())
        XCTAssertFalse(notLeapYear.isLeapYear())
    }
    
    func testIsSameDay(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 09, hour: 20, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isSameDay(tm2))
        XCTAssertFalse(tm1.isSameDay(tm3))
    }
    
    func testIsSunday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 10, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isSunday())
        XCTAssertFalse(tm2.isSunday())
    }
    
    func testIsMonday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 04, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 06, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isMonday())
        XCTAssertFalse(tm2.isMonday())
    }
    
    func testIsTuesday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 05, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 10, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isTuesday())
        XCTAssertFalse(tm2.isTuesday())
    }
    
    func testIsWednesday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 06, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 11, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isWednesday())
        XCTAssertFalse(tm2.isWednesday())
    }
    
    func testIsThursday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 07, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 12, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isThursday())
        XCTAssertFalse(tm2.isThursday())
    }
    
    func testIsFriday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 13, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isFriday())
        XCTAssertFalse(tm2.isFriday())
    }
    
    func testIsSaturday(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 09, hour: 10, minute: 25, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 14, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1.isSaturday())
        XCTAssertFalse(tm2.isSaturday())
    }
    
    func testAddYears(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2017, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2027, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1.addYears(1)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addYears(11)?.rawDate, tm3.rawDate )
    }
    
    func testSubYears(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2017, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2027, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2.subYears(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subYears(11)?.rawDate, tm1.rawDate )
    }
    
    func testAddMonths(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 02, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 10, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1.addMonths(1)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addMonths(9)?.rawDate, tm3.rawDate )
    }
    
    func testSubMonths(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 02, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 10, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2.subMonths(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subMonths(9)?.rawDate, tm1.rawDate )
    }
    
    func testAddDays(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 09, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 19, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1.addDays(1)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addDays(11)?.rawDate, tm3.rawDate )
    }
    
    func testSubDays(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 09, hour: 23, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 19, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2.subDays(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subDays(11)?.rawDate, tm1.rawDate )
    }
    
    func testAddHours(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 2, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 3, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 11)
        XCTAssertEqual( tm1.addHours(1)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addHours(15)?.rawDate, tm3.rawDate )
    }
    
    func testSubHours(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 2, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 3, minute: 25, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 17, minute: 25, second: 11)
        XCTAssertEqual( tm2.subHours(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subHours(15)?.rawDate, tm1.rawDate )
    }
    
    func testAddMinutes(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 09, hour: 00, minute: 05, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 40, second: 11)
        XCTAssertEqual( tm1.addMinutes(40)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addMinutes(15)?.rawDate, tm3.rawDate )
    }
    
    func testSubMinutes(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 26, second: 11)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 40, second: 11)
        XCTAssertEqual( tm2.subMinutes(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subMinutes(15)?.rawDate, tm1.rawDate )
    }
    
    func testAddSecond(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 12)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 26)
        XCTAssertEqual( tm1.addSeconds(1)?.rawDate, tm2.rawDate )
        XCTAssertEqual( tm1.addSeconds(15)?.rawDate, tm3.rawDate )
    }
    
    func testSubSecond(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 12)
        let tm3 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 26)
        XCTAssertEqual( tm2.subSeconds(1)?.rawDate, tm1.rawDate )
        XCTAssertEqual( tm3.subSeconds(15)?.rawDate, tm1.rawDate )
    }
    
    func testDiffInYears(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2040, month: 01, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2.diffInYears(tm1), 24)
        XCTAssertEqual(tm2.diffInYears(tm1, absoluteValue: false), -24)
    }
    
    func testDiffInMonths(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 20, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 02, day: 21, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2.diffInMonths(tm1), 1)
        XCTAssertEqual(tm2.diffInMonths(tm1, absoluteValue: false), -1)
    }
    
    func testDiffInWeeks(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 01, hour: 20, minute: 25, second: 25)
        let tm2 = TimeLord(year: 2016, month: 01, day: 16, hour: 21, minute: 26, second: 30)
        XCTAssertEqual(tm2.diffInWeeks(tm1), 2)
        XCTAssertEqual(tm2.diffInWeeks(tm1, absoluteValue: false), -2)
    }
    
    func testDiffInDays(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 20, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 02, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2.diffInDays(tm1), 19)
        XCTAssertEqual(tm2.diffInDays(tm1, absoluteValue: false), -19)
    }
    
    func testDiffInHours(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 20, hour: 20, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 21, hour: 11, minute: 25, second: 57)
        XCTAssertEqual(tm2.diffInHours(tm1), 15)
        XCTAssertEqual(tm2.diffInHours(tm1, absoluteValue: false), -15)
    }
    
    func testDiffInMinutes(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 20, hour: 20, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 20, hour: 21, minute: 30, second: 57)
        XCTAssertEqual(tm2.diffInMinutes(tm1), 65)
        XCTAssertEqual(tm2.diffInMinutes(tm1, absoluteValue: false), -65)
    }

    func testDiffInSeconds(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2.diffInSeconds(tm1), 46)
        XCTAssertEqual(tm2.diffInSeconds(tm1, absoluteValue: false), -46)
    }
    
    func testInTimeZone(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = tm1.inTimeZone(NSTimeZone(abbreviation: "MSK")!)
        XCTAssertEqual(tm2.toString(), "2016-01-08 19:25:11")
    }
    
    func testStartOfDay(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-10 00:00:00")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).startOfDay()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testEndOfDay(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-10 23:59:59")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).endOfDay()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testStartOfMonth(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-01 00:00:00")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).startOfMonth()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testEndOfMonth(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-31 23:59:59")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).endOfMonth()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testStartOfYear(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-01 00:00:00")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).startOfYear()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testEndOfYear(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-12-31 23:59:59")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).endOfYear()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testNext(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-11 22:11:11")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).next()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }

    func testPrevious(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-09 22:11:11")
        let tmDate = TimeLord(year: 2016, month: 01, day: 10, hour: 22, minute: 11, second: 11).previous()
        XCTAssertEqual(nsDate, tmDate.rawDate)
    }
    
    func testAverage(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 02, hour: 10, minute: 30, second: 00)
        let average1 = tm1.average(tm2)
        let average2 = tm2.average(tm1)
        XCTAssertEqual(average1.toString(), "2016-01-01 18:30:00")
        XCTAssertEqual(average2.toString(), "2016-01-01 18:30:00")
    }
    
    func testCompare(){
        let tm1 = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
        let tm2 = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
        let tm3 = TimeLord(year: 2016, month: 01, day: 02, hour: 18, minute: 30, second: 45)
        let tm4 = TimeLord(year: 2016, month: 01, day: 02, hour: 18, minute: 35, second: 45)
        XCTAssertTrue(tm1 == tm2)
        XCTAssertTrue(tm1 != tm3)
        XCTAssertTrue(tm1 < tm3)
        XCTAssertTrue(tm3 <= tm4)
        XCTAssertTrue(tm1 <= tm2)
        XCTAssertTrue(tm4 > tm3)
        XCTAssertTrue(tm3 >= tm2)
        XCTAssertTrue(tm1 >= tm2)
        XCTAssertFalse(tm1 == tm3)
        XCTAssertFalse(tm1 != tm2)
        XCTAssertFalse(tm1 < tm2)
        XCTAssertFalse(tm4 < tm2)
        XCTAssertFalse(tm4 <= tm2)
        XCTAssertFalse(tm1 > tm3)
        XCTAssertFalse(tm1 > tm2)
        XCTAssertFalse(tm1 >= tm4)
    }
    
    func testHashable(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.dateFromString("2016-01-09 22:11:11")
        let tmDate = TimeLord(year: 2016, month: 01, day: 09, hour: 22, minute: 11, second: 11)
        XCTAssertEqual(nsDate!.hashValue, tmDate.hashValue)
    }
    
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
