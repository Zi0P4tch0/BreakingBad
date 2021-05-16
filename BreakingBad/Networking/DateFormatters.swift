import Foundation

/// Character birthday date formatter.
let birthdayDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter
}()
