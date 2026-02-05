//
//  TransactionItem.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import SwiftUI

struct TransactionItem: Codable, Identifiable {

    let transaction_id: UUID
    let amount: Double
    let note: String?
    let type: String
    let created_at: String

    let wallet: WalletMini
    let destination_wallet: WalletMini?
    let category: CategoryMini?

    var id: UUID { transaction_id }

    var isIncome: Bool { type == "income" }
    var isTransfer: Bool { type == "transfer" }

    var title: String {
        if isTransfer { return "Transfer" }
        return category?.name ?? "Transaksi"
    }

    var color: Color {
        if isIncome { return .green }
        if isTransfer { return .blue }
        return .red
    }

    var iconName: String {
        SFSymbolMapper.map(category?.icon ?? wallet.icon)
    }

    // 🔥 PENTING
    var createdAt: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: created_at) ?? Date()
    }

}

// MARK: - Nested

struct WalletMini: Codable {
    let id: UUID
    let name: String
    let icon: String
}

struct CategoryMini: Codable {
    let id: UUID
    let name: String
    let icon: String
    let color: String
}
