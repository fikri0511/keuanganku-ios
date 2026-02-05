//
//  Date+Format.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 05/02/26.
//

import Foundation

extension Date {
    func toDayHeader() -> String {
        let f = DateFormatter()
        f.dateFormat = "d MMMM yyyy"
        f.locale = Locale(identifier: "id_ID")
        return f.string(from: self)
    }

    func toHourMinute() -> String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"   // ⬅️ ini doang
        return f.string(from: self)
    }
}

extension Date {

    func toRelativeTime() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))

        if secondsAgo < 60 {
            return "Baru saja"
        }

        let minutes = secondsAgo / 60
        if minutes < 60 {
            return "\(minutes) menit yang lalu"
        }

        let hours = minutes / 60
        if hours < 24 {
            return "\(hours) jam yang lalu"
        }

        let days = hours / 24
        return "\(days) hari yang lalu"
    }
}
