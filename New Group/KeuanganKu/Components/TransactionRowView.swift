//
//  TransactionRowView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

//
//  TransactionRowView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct TransactionRowView: View {
    let item: TransactionItem

    var body: some View {
        HStack(spacing: 12) {

            Circle()
                .fill(item.isIncome ? Color.green.opacity(0.15) : Color.red.opacity(0.15))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: item.iconName)
                        .foregroundColor(item.isIncome ? .green : .red)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(item.source)
                    .font(.caption)
                    .foregroundColor(.gray)

                if !item.note.isEmpty {
                    Text(item.note)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            HStack(spacing: 8) {
                Text("\(item.isIncome ? "+" : "-") Rp \(item.amount)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(item.isIncome ? .green : .red)

                Menu {
                    Button("Edit") {}
                    Button("Hapus", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }

        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
    }
}
