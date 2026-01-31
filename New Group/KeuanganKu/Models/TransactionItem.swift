//
//  TransactionItem.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//


import SwiftUI

struct TransactionItem: Identifiable {
    let id = UUID()
    let title: String
    let source: String
    let note: String
    let amount: Int
    let isIncome: Bool
    
    var iconName: String {
        switch title.lowercased() {
        case "makanan":
            return "fork.knife"
        case "transport":
            return "car.fill"
        case "tagihan":
            return "doc.text"
        case "gaji":
            return "gift.fill"
        default:
            return "creditcard"
        }
    }
}

