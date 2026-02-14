//
//  AppStyle.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 02/02/26.
//

import SwiftUI

enum AppColor {
    static let primary = Color(red: 0.05, green: 0.55, blue: 0.45)
    static let bg = Color(.systemGroupedBackground)
    static let income = Color.green
    static let expense = Color.red
}

enum AppFont {
    static let title = Font.system(size: 22, weight: .bold)
    static let subtitle = Font.system(size: 14)
    static let amount = Font.system(size: 18, weight: .semibold)

    // Tambahan untuk Setting
    static let label = Font.system(size: 13)
    static let body = Font.system(size: 16, weight: .semibold)
    static let caption = Font.system(size: 12)
}
