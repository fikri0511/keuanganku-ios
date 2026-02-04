//
//  LastTransactionRow.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import SwiftUI

struct LastTransactionRow: View {
    let transaction: TransactionItem

    var body: some View {
        HStack(spacing: 14) {

            // ICON
            Circle()
                .fill(transaction.color.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: transaction.iconName)
                        .foregroundStyle(transaction.color)
                )

            // TEXT KIRI
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.title)
                    .font(.subheadline.weight(.semibold))

                Text(transaction.wallet.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                // NOTE di paling bawah
                if let note = transaction.note, !note.isEmpty {
                    Text(note)
                        .font(.caption2)
                        .foregroundStyle(.secondary.opacity(0.7))
                }
            }

            Spacer()

            // KANAN (UANG + TITIK TIGA)
            HStack(alignment: .center, spacing: 8) {

                Text(amountText)
                    .font(.subheadline.bold())
                    .foregroundStyle(transaction.color)

                Menu {
                    Button {
                        print("Edit tapped")
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }

                    Button(role: .destructive) {
                        print("Delete tapped")
                    } label: {
                        Label("Hapus", systemImage: "trash")
                    }

                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
    }

    // MARK: + / - FORMAT

    var amountText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.maximumFractionDigits = 0

        let formatted = formatter.string(from: NSNumber(value: transaction.amount)) ?? "Rp 0"

        if transaction.isIncome {
            return "+ \(formatted)"
        } else if transaction.isTransfer {
            return formatted
        } else {
            return "- \(formatted)"
        }
    }
}
