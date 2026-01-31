//
//  WalletType.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

enum WalletType: String, CaseIterable {
    case gopay = "GoPay"
    case bca = "Bank BCA"
    case cash = "Dompet Cash"

    var amount: Int {
        switch self {
        case .gopay: return 100_000
        case .bca: return 250_000
        case .cash: return 0
        }
    }
}
