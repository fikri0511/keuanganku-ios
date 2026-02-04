//
//  Currency+Ext.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 03/02/26.
//

import Foundation

extension Double {
    func toRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0

        let numberString = formatter.string(from: NSNumber(value: self)) ?? "0"
        return "Rp \(numberString)"
    }
}
