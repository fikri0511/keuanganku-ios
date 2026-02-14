//
//  Gradient+Extension.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 10/02/26.
//

import SwiftUI

extension LinearGradient {
    static var brandGradient: LinearGradient {
        LinearGradient(
            colors: [
                AppColor.primary,
                AppColor.primary.opacity(0.7)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
