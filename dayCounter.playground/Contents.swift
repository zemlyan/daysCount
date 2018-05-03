import UIKit
import Foundation

var finalDays = Int()

let monthCalendar = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
]

var calendar = [
    monthCalendar[0] : 31,
    monthCalendar[1] : 28,
    monthCalendar[2] : 31,
    monthCalendar[3] : 30,
    monthCalendar[4] : 31,
    monthCalendar[5] : 30,
    monthCalendar[6] : 31,
    monthCalendar[7] : 31,
    monthCalendar[8] : 30,
    monthCalendar[9] : 31,
    monthCalendar[10] : 30,
    monthCalendar[11] : 31
]

let formatter = NumberFormatter()
formatter.numberStyle = NumberFormatter.Style.decimal

var formattedDays = String()
var frase = ""

var yearDays = 365
var fullYear = Int()

var beginYear = 1974
var lastYear = 2018
var yearsTotal = 0

var beginMonth = "February"
var lastMonth = "May"
var daysInMonthTotal = 0

var beginDay = 8
var lastDay = 2
var totalDays = 0

// Validating dates
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

let beginYearUnsigned = beginYear < 0 ? beginYear * -1 : beginYear
let lastYearUnsigned = lastYear < 0 ? lastYear * -1 : lastYear

let beginMonthInt = monthCalendar.index(of: beginMonth)! + 1
let lastMonthInt = monthCalendar.index(of: lastMonth)! + 1
let beginMonthString = beginMonthInt < 10 ? "0\(beginMonthInt)" : "\(beginMonthInt)"
let lastMonthString = lastMonthInt < 10 ? "0\(lastMonthInt)" : "\(lastMonthInt)"
let beginDayString = beginDay < 10 ? "0\(beginDay)" : "\(beginDay)"
let lastDayString = lastDay < 10 ? "0\(lastDay)" : "\(lastDay)"

let beginDate = dateFormatter.date(from: "\(beginYearUnsigned)-\(beginMonthString)-\(beginDayString)")
let lastDate = dateFormatter.date(from: "\(lastYearUnsigned)-\(lastMonthString)-\(lastDayString)")
let beginDateInt = Int("\(beginYear)\(beginMonthString)\(beginDayString)")
let lastDateInt = Int("\(lastYear)\(lastMonthString)\(lastDayString)")


extension Int {
    var ifThisIntegerRepresentsAYearCheckIfItIsALeapYear: Bool {
        return self % 4 == 0 && self % 100 != 0 && self != 0 || self % 400 == 0 && self != 0
    }
}

if let beginDate = beginDate, let lastDate = lastDate, let beginDateInt = beginDateInt, let lastDateInt = lastDateInt {
    if beginDateInt == lastDateInt { fatalError("You chose the same dates in both start and finish dates") }
    if beginDateInt > lastDateInt { fatalError("Begin date must be smaller then last date") }
} else  { fatalError("Please enter valid dates") }

// counting years
if (beginYear != lastYear) && (beginYear + 1 != lastYear) {
    for var yearCount in (beginYear + 1)...(lastYear - 1) {
        if yearCount != 0 {
            yearsTotal += 1
        }
        
        if yearCount.ifThisIntegerRepresentsAYearCheckIfItIsALeapYear {
            fullYear += 1
        }
        yearCount = beginYear + 1
    }
}
yearsTotal = yearsTotal * 365 + fullYear

// counting months
if (beginYear != lastYear) {
    
    if beginYear % 4 == 0 {
        calendar[monthCalendar[1]] = 29
    } else {
        calendar[monthCalendar[1]] = 28
    }
    if monthCalendar.index(of: beginMonth)! != 11 {
        for monthIndex in (monthCalendar.index(of: beginMonth)! + 1)...11 {
            daysInMonthTotal += calendar[monthCalendar[monthIndex]]!
        }
    }
    if lastYear % 4 == 0 {
        calendar[monthCalendar[1]] = 29
    } else {
        calendar[monthCalendar[1]] = 28
    }
    if monthCalendar.index(of: lastMonth)! != 0 {
        for monthIndex in 0...(monthCalendar.index(of: lastMonth)! - 1){
            daysInMonthTotal += calendar[monthCalendar[monthIndex]]!
        }
    }
    daysInMonthTotal
}else {
    if (monthCalendar.index(of: beginMonth)! + 1) <= (monthCalendar.index(of: lastMonth)! - 1) {
        for monthIndex in (monthCalendar.index(of: beginMonth)! + 1)...(monthCalendar.index(of: lastMonth)! - 1) {
            daysInMonthTotal += calendar[monthCalendar[monthIndex]]!
        }
    }
}
// end of counting months

// counting days

if (beginYear == lastYear) && (beginMonth == lastMonth) {
    totalDays = lastDay - beginDay + 1
} else {
    totalDays = (calendar[beginMonth]! - beginDay + 1) + lastDay
}


finalDays = yearsTotal + daysInMonthTotal + totalDays
if finalDays == 1 {
    print("1 day")
} else {
    formattedDays = formatter.string(for: finalDays)!
    frase = "\(formattedDays) days"
    print (frase)
}

