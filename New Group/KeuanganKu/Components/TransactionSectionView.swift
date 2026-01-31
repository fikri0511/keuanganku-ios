//
//  TransactionSectionView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI
struct TransactionSectionView: View {
    let date: String
    let transactions: [TransactionItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(date)
                .font(.caption)
                .foregroundColor(.gray)

            ForEach(transactions) { item in
                TransactionRowView(item: item)
            }
        }
    }
}
