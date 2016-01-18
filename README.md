# TimeLord
Is simple structure encapsulating NSDate, NSCalendar, NSDateComponents, NSDateFormatter and provide new data type making operation with dates easy.

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
    - [Create date](#create-date)
    - [Get date components](#get-date-components)
    - [Get date as string](#get-date-as-string)
    - [Compare dates](#compare-dates)
    - [Modify date](#modify-date)
    - [Get difference between date](#get-difference-between-date)

## Features

- [x] Create date in any format and timezone
- [x] Get date in any format and timezone
- [x] Get date components (like year, month, second, etc)
- [x] Many features for compare date
- [x] Modyfy date, add or sub any date component
- [x] Get diference between date


## Requirements

* iOS 8.0+ / Mac OS X 10.9+ / tvOS 9.0+ / watchOS 2.0+
* Xcode 7.2+

## Communication

* If you need help, use Stack Overflow. (Tag 'JFTimeLord')
* If you'd like to ask a general question, use Stack Overflow.
* If you found a bug, open an issue.
* If you have a feature request, open an issue.
* If you want to contribute, submit a pull request.


## Installation

### Carthage

Add it in your Cartfile:
```ogdl
github "JonFir/TimeLord"
```
Run `carthage update` to build the framework and drag the built TimeLord.framework into your Xcode project.

### Manually

Just copy TimeLord.swift into your project


## Usage

```swift
import TimeLord

let firstDate = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
let secondDate = TimeLord(year: 2015, month: 01, day: 01, hour: 02, minute: 30, second: 00)
let nowDate = TimeLord(keyWord: .Now)

if nowDate >  firstDate {
 ...
}

let newDate = secondDate.toString()
let newDate = firstDate.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: NSTimeZone(abbreviation: "MSK"))
let newDate = secondDate.addYears(11).addMonths(9).subDays(1)
```

### Create date

```swift
// form NSDate
let date = TimeLord(date: NSDate())
// form date components
let date = TimeLord(year: 2016, month: 01, day: 08, hour: 14, minute: 25, second: 00)
let date = TimeLord(year: 2016, month: 01, day: 08, hour: 10, minute: 25, second: 00, timeZone: NSTimeZone(abbreviation: "MSK"))
// form string
let date = TimeLord(date: "2016-01-08 13:38:00")
let date = TimeLord(date: "2016-01-08 13:38:00", inFormat: "yyyy-MM-dd HH:mm:ss")
let date = TimeLord(date: "2016-01-08 09:38:00", inFormat: "yyyy-MM-dd HH:mm:ss", timeZone: NSTimeZone(abbreviation: "MSK"))
// from time interval
let date = TimeLord(timeIntervalSince1970: 1452243489)
let date = TimeLord(timeIntervalSinceNow: 1452243489)
let date = TimeLord(timeInterval: 1452243489, sinceDate: date)
let date = TimeLord(timeIntervalSinceReferenceDate: 1452243489)
// from key word
let date = TimeLord(keyWord: .Now)
let date = TimeLord(keyWord: .Today)
let date = TimeLord(keyWord: .Tomorrow)
let date = TimeLord(keyWord: .Yesterday)
```

### Get date components

```swift
let tmDateInDefaultFormat = TimeLord(date: "2016-01-08 13:38:00")
let year = tmDateInDefaultFormat?.year
let month = tmDateInDefaultFormat?.month

let day = tmDateInDefaultFormat?.day
let hour = tmDateInDefaultFormat?.hour

let minute = tmDateInDefaultFormat?.minute
let second = tmDateInDefaultFormat?.second

let nanosecond = tmDateInDefaultFormat?.nanosecond
let dayInMonth = tmDateInDefaultFormat?.dayInMonth

let weekday = tmDateInDefaultFormat?.weekday
let weekdaySymbol = tmDateInDefaultFormat?.weekdaySymbol

let weekdayOrdinal = tmDateInDefaultFormat?.weekdayOrdinal
let quarter = tmDateInDefaultFormat?.quarter

let weekOfMonth = tmDateInDefaultFormat?.weekOfMonth
let weekOfYear = tmDateInDefaultFormat?.weekOfYear

let yearForWeekOfYear = tmDateInDefaultFormat?.yearForWeekOfYear
let era = tmDateInDefaultFormat?.era
```

### Get date as string

```swift
let date = TimeLord(year: 2016, month: 01, day: 08, hour: 23, minute: 00, second: 00)

date.toString()                               // "2016-01-08 23:00:00"
date.toStringInFormat("yyyy-MM-dd HH:mm:ss")  // "2016-01-08 23:00:00"
date.toStringInFormat("yyyy-MM-dd HH:mm:ss", inTimeZone: NSTimeZone(abbreviation: "MSK")) //"2016-01-08 19:00:00"

date.toFormattedDateString()      // "янв. 8, 2016"
date.toTimeString()               // "23:25:40"

date.toDateTimeString()           // "2016-01-08 23:25:40"
date.toDayDateTimeString()        // "пт, янв. 8, 2016 11:25 PM"

date.toAtomString()               // "2016-01-08T23:25:40+07:00"
date.toCookieString()             // "пятница, 08-янв.-2016 23:25:40 GMT+7"

date.toIso8601String()            // "2016-01-08T23:25:40+0700"
date.toRfc822String()             // "пт, 08 янв. 16 23:25:40 +0700"

date.toRfc850String()             // "пятница, 08-янв.-16 23:25:40 GMT+7"
date.toRfc1036String()            // "пт, 08 янв. 16 23:25:40 +0700"

date.toRfc1123String()            // "пт, 08 янв. 2016 23:25:40 +0700"
date.toRfc2822String()            // "пт, 08 янв. 2016 23:25:40 +0700"

date.toRfc3339String()            // "2016-01-08T23:25:40+07:00"
date.toW3cString()                // "2016-01-08T23:25:40+07:00"

date.toRssString()                // "пт, 08 янв. 2016 23:25:40 +0700"
```

### Compare dates

```swift
let date1 = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
let date2 = TimeLord(year: 2016, month: 01, day: 01, hour: 02, minute: 30, second: 00)
let date3 = TimeLord(year: 2016, month: 01, day: 02, hour: 18, minute: 30, second: 45)
let date4 = TimeLord(year: 2016, month: 01, day: 02, hour: 22, minute: 35, second: 45)

if date1 == date2  {...}
if date1 != date3 {...}
if date1 < date3  {...}
if date3 <= date4  {...}
if date1 <= date2  {...}
if date4 > date3  {...}
if date3 >= date2  {...}
if date1 >= date2  {...}

if date3.between(date1, second: date4)  {...}

let date = date1.closest(date3, second: date4)    // return date3
let date = date1.farthest(date3, second: date4)   // return date4
let date = date1.earlier(date3)                   // return date1
let date = date1.later(date3)                     // return date3


if date.isWeekend()  {...}
if date.isYesterday()  {...}
if date.isToday()  {...}
if date.isTomorrow()  {...}
if date.isFuture()  {...}
if date.isPast()  {...}
if date.isLeapYear()  {...}
if date.isSameDay(tm2)  {...}

if date.isSunday()  {...}
if date.isMonday()  {...}
if date.isTuesday()  {...}
if date.isWednesday()  {...}
if date.isThursday()  {...}
if date.isFriday()  {...}
if date.isSaturday()  {...}
```

### Modify date

```swift
let newDate = date.addYears(1)
let newDate = date.subYears(1)

let newDate = date.addMonths(9)
let newDate = date.subMonths(1)

let newDate = date.addDays(11)
let newDate = date.subDays(11)

let newDate = date.addHours(1)
let newDate = date.subHours(1)

let newDate = date.addMinutes(15)
let newDate = date.subMinutes(15)

let newDate = date.addSeconds(1)
let newDate = date.subSeconds(15)


let newDate = date.addYears(1).addMonths(9).addSeconds(1)

let newDate = date.next()     //nextDay
let newDate = date.previous() //prevDay

let newDate = date.inTimeZone(NSTimeZone(abbreviation: "MSK")!)
let newDate = date.startOfDay()

let newDate = date.endOfDay()
let newDate = date.startOfMonth()

let newDate = date.endOfMonth()
let newDate = date.startOfYear()

let newDate = date.endOfYear()
let newDate = date.average(anotherDay)
```

### Get difference between date

```swift
let newDate = firstDate.diffInYears(secondDate)
let newDate = firstDate.diffInMonths(secondDate)

let newDate = firstDate.diffInWeeks(secondDate)
let newDate = firstDate.diffInDays(secondDate)

let newDate = firstDate.diffInHours(secondDate)
let newDate = firstDate.diffInMinutes(secondDate)

let newDate = firstDate.diffInSeconds(secondDate)
```
