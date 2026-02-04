//
//  AppGradient.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 03/02/26.
//

import SwiftUI

extension LinearGradient {
    static let appPrimary = LinearGradient(
        colors: [
            Color(red: 0.05, green: 0.45, blue: 0.45),
            Color(red: 0.02, green: 0.30, blue: 0.30)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}
