//
//  RecentTransactionRow.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 05/02/26.
//

import SwiftUI
import Combine

struct RecentTransactionRow: View {
    let transaction: TransactionItem

    @State private var now = Date()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 14) {
            
            Circle()
                .fill(transaction.color.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: transaction.iconName)
                        .foregroundStyle(transaction.color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(transaction.title)
                    .font(.subheadline.weight(.semibold))
                
                Text(transaction.wallet.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(transaction.createdAt.toRelativeTime())
                    .font(.caption2)
                    .foregroundStyle(.secondary.opacity(0.7))
                
                if let note = transaction.note, !note.isEmpty {
                    Text(note)
                        .font(.caption2)
                        .foregroundStyle(.secondary.opacity(0.7))
                }
            }
            
            
            Spacer()
        
            HStack(spacing: 8) {
                Text(amountText)
                    .font(.subheadline.bold())
                    .foregroundStyle(transaction.color)
                    .monospacedDigit()
                    .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] }

                Menu {
                    Button("Edit", systemImage: "pencil") {}
                    Button("Hapus", systemImage: "trash", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray)
                }
            }
            
        }
        .padding(16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
    )
        .onReceive(timer) { _ in
            now = Date() // biar realtime update
        }
    }

    var amountText: String {
        let number = abs(transaction.amount).toNumberString()

        if transaction.isIncome {
            return "+ \(number)"
        } else {
            return "- \(number)"
        }
    }
}
