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
        
        let fff = Date.NSDateFromString("sdfds", inFormat: "we")
        XCTAssertNil(fff, "")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testDateUnitGetter(){
        let tmDateInDefaultFormat = Date.NSDateFromString("2016-01-08 13:38:00")
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
    
    func testInitFromDateUnit(){
        
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 14, minute: 25, second: 00, timeZone: TimeZone(abbreviation: "KRAS"))
        XCTAssertEqual(tm1!.toString(), "2016-01-08 14:25:00")
        
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00, timeZone: TimeZone(abbreviation: "MSK"))
        XCTAssertEqual(tm2!.toString(TimeZone(abbreviation: "MSK")), "2016-01-08 10:25:00")
        XCTAssertEqual(tm1, tm2)
        
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 14, minute: 25, second: 00)
        XCTAssertEqual(tm3!.toString(), "2016-01-08 14:25:00")
        XCTAssertEqual(tm1, tm3)
    }
    
    func testInitFromString(){
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateformater.date(from: "2016-01-08 13:38:00")
        
        let tmDateInDefaultFormat = Date.NSDateFromString("2016-01-08 13:38:00")
        let tmDateInCustomFormat = Date.NSDateFromString("2016-01-08 13:38:00", inFormat: "yyyy-MM-dd HH:mm:ss")
        let tmDateInCustomFormatAndTimeZone = Date.NSDateFromString("2016-01-08 09:38:00", inFormat: "yyyy-MM-dd HH:mm:ss", timeZone: TimeZone(abbreviation: "MSK"))
        XCTAssertEqual(nsDate, tmDateInDefaultFormat!, "date should equal")
        XCTAssertEqual(nsDate, tmDateInCustomFormat!, "date should equal")
        XCTAssertEqual(nsDate, tmDateInCustomFormatAndTimeZone!, "date should equal")
    }
    
    func testInitFormKeyWord(){
        let nsNow = Date()
        let tmNow = Date.NSDateAtKeyWord(.now)
        let dateformater = DateFormatter()
        dateformater.dateFormat = "yyyy-MM-dd HH:mm"
        let nsString = dateformater.string(from: nsNow)
        let tmString = tmNow.toStringInFormat("yyyy-MM-dd HH:mm")
        XCTAssertEqual(nsString, tmString)
        
        
        let tmToday = Date.NSDateAtKeyWord(.today)
        let nsToday = Calendar.current.startOfDay(for: Date())
        XCTAssertEqual(nsToday, tmToday)
        
        let tmTomorrow = Date.NSDateAtKeyWord(.tomorrow)
        let nsTomorrow = (Calendar.current as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: 1, to: nsToday, options: [])
        XCTAssertEqual(nsTomorrow, tmTomorrow)
        
        let tmYesterday = Date.NSDateAtKeyWord(.yesterday)
        let nsYesterday = (Calendar.current as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: -1, to: nsToday, options: [])
        XCTAssertEqual(nsYesterday, tmYesterday)
    }
    
    func testToString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm!.toString(), "2016-01-08 23:00:00")
    }
    
    func testToStringInFormat(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm!.toStringInFormat("yyyy-MM-dd HH:mm:ss"), "2016-01-08 23:00:00")
        XCTAssertEqual(tm!.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: TimeZone(abbreviation: "MSK")), "2016-01-08 19:00:00")
    }
    
    func testToFormattedDateString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)
        XCTAssertEqual(tm!.toFormattedDateString(), "янв. 8, 2016")
    }
    
    func testTimeString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toTimeString(), "23:25:40")
    }
    
    func testToDateTimeString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toDateTimeString(), "2016-01-08 23:25:40")
    }
    
    func testToDayDateTimeString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toDayDateTimeString(), "пт, янв. 8, 2016 11:25 ПП")
    }
    
    func testToAtomString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toAtomString(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToCookieString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toCookieString(), "пятница, 08-янв.-2016 23:25:40 GMT+7")
    }
    
    func testToIso8601String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toIso8601String(), "2016-01-08T23:25:40+0700")
    }
    
    func testToRfc822String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc822String(), "пт, 08 янв. 16 23:25:40 +0700")
    }
    
    func testToRfc850String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc850String(), "пятница, 08-янв.-16 23:25:40 GMT+7")
    }
    
    func testToRfc1036String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc1036String(), "пт, 08 янв. 16 23:25:40 +0700")
    }
    
    func testToRfc1123String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc1123String(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testToRfc2822String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc2822String(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testToRfc3339String(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRfc3339String(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToW3cString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toW3cString(), "2016-01-08T23:25:40+07:00")
    }
    
    func testToRssString(){
        let tm = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 40)
        XCTAssertEqual(tm!.toRssString(), "пт, 08 янв. 2016 23:25:40 +0700")
    }
    
    func testBetween(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 20, minute: 25, second: 40)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 22, minute: 25, second: 40)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 24, minute: 25, second: 40)
        
        XCTAssertFalse(tm1!.between(tm2!, second: tm3!))
        XCTAssertTrue(tm2!.between(tm1!, second: tm3!))
    }
    
    func testClosest(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm1!.closest(tm2!, second: tm3!), tm2!)
        XCTAssertEqual(tm1!.closest(tm3!, second: tm2!), tm2!)
    }

    func testFarthest(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm1!.farthest(tm2!, second: tm3!), tm3!)
        XCTAssertEqual(tm1!.farthest(tm3!, second: tm2!), tm3!)
    }

    func testEarlier(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm2!.earlier(tm1!), tm1)
        XCTAssertEqual(tm2!.earlier(tm3!), tm2)
    }
    
    func testLater(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 20, minute: 25, second: 00)
        
        XCTAssertEqual(tm2!.later(tm1!), tm2!)
        XCTAssertEqual(tm2!.later(tm3!), tm3!)
    }
    
    func testIsWeekend(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm2!.isWeekend())
        XCTAssertFalse(tm1!.isWeekend())
    }
    
    func testIsYesterday(){
        let nsYesterday = (Calendar.current as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])
        let tmNow = Date()
        XCTAssertTrue(nsYesterday!.isYesterday())
        XCTAssertFalse(tmNow.isYesterday())
    }
    
    func testIsToday(){
        let nsTommorow = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
        let tmNow = Date()
        XCTAssertTrue(tmNow.isToday())
        XCTAssertFalse(nsTommorow!.isToday())
    }
    
    func testIsTomorrow(){
        let nsTommorow = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
        let tmNow = Date()
        XCTAssertTrue(nsTommorow!.isTomorrow())
        XCTAssertFalse(tmNow.isTomorrow())
    }
    
    func testIsFuture(){
        let nsTommorow = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
        let nsYesterday = (Calendar.current as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])
        
        XCTAssertTrue(nsTommorow!.isFuture())
        XCTAssertFalse(nsYesterday!.isFuture())
    }
    
    func testIsPast(){
        let nsTommorow = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options: [])
        let nsYesterday = (Calendar.current as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])
        
        XCTAssertFalse(nsTommorow!.isPast())
        XCTAssertTrue(nsYesterday!.isPast())
    }
    
    func testIsLeapYear(){
        let leapYear = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let notLeapYear = Date.NSDateFromYear(2015, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(leapYear!.isLeapYear())
        XCTAssertFalse(notLeapYear!.isLeapYear())
    }
    
    func testIsSameDay(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 00)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 20, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isSameDay(tm2!))
        XCTAssertFalse(tm1!.isSameDay(tm3!))
    }
    
    func testIsSunday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isSunday())
        XCTAssertFalse(tm2!.isSunday())
    }
    
    func testIsMonday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 04, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 06, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isMonday())
        XCTAssertFalse(tm2!.isMonday())
    }
    
    func testIsTuesday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 05, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isTuesday())
        XCTAssertFalse(tm2!.isTuesday())
    }
    
    func testIsWednesday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 06, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 11, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isWednesday())
        XCTAssertFalse(tm2!.isWednesday())
    }
    
    func testIsThursday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 07, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 12, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isThursday())
        XCTAssertFalse(tm2!.isThursday())
    }
    
    func testIsFriday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 13, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isFriday())
        XCTAssertFalse(tm2!.isFriday())
    }
    
    func testIsSaturday(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 10, minute: 25, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 14, hour: 17, minute: 25, second: 00)
        
        XCTAssertTrue(tm1!.isSaturday())
        XCTAssertFalse(tm2!.isSaturday())
    }
    
    func testAddYears(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2017, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2027, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1!.addYears(1), tm2 )
        XCTAssertEqual( tm1!.addYears(11), tm3 )
    }
    
    func testSubYears(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2017, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2027, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2!.subYears(1), tm1 )
        XCTAssertEqual( tm3!.subYears(11), tm1 )
    }
    
    func testAddMonths(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 02, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 10, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1!.addMonths(1), tm2 )
        XCTAssertEqual( tm1!.addMonths(9), tm3 )
    }
    
    func testSubMonths(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 02, day: 08, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 10, day: 08, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2!.subMonths(1), tm1 )
        XCTAssertEqual( tm3!.subMonths(9), tm1 )
    }
    
    func testAddDays(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 19, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm1!.addDays(1), tm2 )
        XCTAssertEqual( tm1!.addDays(11), tm3 )
    }
    
    func testSubDays(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 23, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 19, hour: 23, minute: 25, second: 11)
        XCTAssertEqual( tm2!.subDays(1), tm1 )
        XCTAssertEqual( tm3!.subDays(11), tm1 )
    }
    
    func testAddHours(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 2, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 3, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 11)
        XCTAssertEqual( tm1!.addHours(1), tm2 )
        XCTAssertEqual( tm1!.addHours(15), tm3 )
    }
    
    func testSubHours(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 2, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 3, minute: 25, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 17, minute: 25, second: 11)
        XCTAssertEqual( tm2!.subHours(1), tm1 )
        XCTAssertEqual( tm3!.subHours(15), tm1 )
    }
    
    func testAddMinutes(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 00, minute: 05, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 40, second: 11)
        XCTAssertEqual( tm1!.addMinutes(40), tm2 )
        XCTAssertEqual( tm1!.addMinutes(15), tm3 )
    }
    
    func testSubMinutes(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 26, second: 11)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 40, second: 11)
        XCTAssertEqual( tm2!.subMinutes(1), tm1 )
        XCTAssertEqual( tm3!.subMinutes(15), tm1 )
    }
    
    func testAddSecond(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 12)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 26)
        XCTAssertEqual( tm1!.addSeconds(1), tm2 )
        XCTAssertEqual( tm1!.addSeconds(15), tm3 )
    }
    
    func testSubSecond(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 12)
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 26)
        XCTAssertEqual( tm2!.subSeconds(1), tm1 )
        XCTAssertEqual( tm3!.subSeconds(15), tm1 )
    }
    
    func testDiffInYears(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2040, month: 01, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2!.diffInYears(tm1!), 24)
        XCTAssertEqual(tm2!.diffInYears(tm1!, absoluteValue: false), -24)
    }
    
    func testDiffInMonths(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 20, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 02, day: 21, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2!.diffInMonths(tm1!), 1)
        XCTAssertEqual(tm2!.diffInMonths(tm1!, absoluteValue: false), -1)
    }
    
    func testDiffInWeeks(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 01, hour: 20, minute: 25, second: 25)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 16, hour: 21, minute: 26, second: 30)
        XCTAssertEqual(tm2!.diffInWeeks(tm1!), 2)
        XCTAssertEqual(tm2!.diffInWeeks(tm1!, absoluteValue: false), -2)
    }
    
    func testDiffInDays(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 20, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 02, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2!.diffInDays(tm1!), 19)
        XCTAssertEqual(tm2!.diffInDays(tm1!, absoluteValue: false), -19)
    }
    
    func testDiffInHours(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 20, hour: 20, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 21, hour: 11, minute: 25, second: 57)
        XCTAssertEqual(tm2!.diffInHours(tm1!), 15)
        XCTAssertEqual(tm2!.diffInHours(tm1!, absoluteValue: false), -15)
    }
    
    func testDiffInMinutes(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 20, hour: 20, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 20, hour: 21, minute: 30, second: 57)
        XCTAssertEqual(tm2!.diffInMinutes(tm1!), 65)
        XCTAssertEqual(tm2!.diffInMinutes(tm1!, absoluteValue: false), -65)
    }

    func testDiffInSeconds(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 11)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 08, hour: 23, minute: 25, second: 57)
        XCTAssertEqual(tm2!.diffInSeconds(tm1!), 46)
        XCTAssertEqual(tm2!.diffInSeconds(tm1!, absoluteValue: false), -46)
    }
    
    func testStartOfDay(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-10 00:00:00")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.startOfDay()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testEndOfDay(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-10 23:59:59")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.endOfDay()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testStartOfMonth(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-01 00:00:00")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.startOfMonth()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testEndOfMonth(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-31 23:59:59")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.endOfMonth()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testStartOfYear(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-01 00:00:00")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.startOfYear()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testEndOfYear(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-12-31 23:59:59")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.endOfYear()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testNext(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-11 22:11:11")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.next()
        XCTAssertEqual(nsDate, tmDate)
    }

    func testPrevious(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-09 22:11:11")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 10, hour: 22, minute: 11, second: 11)!.previous()
        XCTAssertEqual(nsDate, tmDate)
    }
    
    func testAverage(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 02, hour: 10, minute: 30, second: 00)
        let average1 = tm1!.average(tm2!)
        let average2 = tm2!.average(tm1!)
        XCTAssertEqual(average1.toString(), "2016-01-01 18:30:00")
        XCTAssertEqual(average2.toString(), "2016-01-01 18:30:00")
    }
    
    func testCompare(){
        let tm1 = Date.NSDateFromYear(2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)!
        let tm2 = Date.NSDateFromYear(2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)!
        let tm3 = Date.NSDateFromYear(2016, month: 01, day: 02, hour: 18, minute: 30, second: 45)!
        let tm4 = Date.NSDateFromYear(2016, month: 01, day: 02, hour: 18, minute: 35, second: 45)!
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nsDate = dateFormatter.date(from: "2016-01-09 22:11:11")
        let tmDate = Date.NSDateFromYear(2016, month: 01, day: 09, hour: 22, minute: 11, second: 11)
        XCTAssertEqual(nsDate!.hashValue, tmDate!.hashValue)
    }
    
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
