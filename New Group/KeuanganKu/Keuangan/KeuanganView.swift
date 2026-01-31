//
//  ContentView.swift
//  Keuanganku
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct KeuanganView: View {

    @State private var transactions: [TransactionItem] = [
        TransactionItem(
            title: "Makanan",
            source: "Bank BCA",
            note: "4 hari yang lalu",
            amount: 50000,
            isIncome: false
        ),
        TransactionItem(
            title: "Gaji",
            source: "GoPay",
            note: "21 Jan 2026",
            amount: 10000,
            isIncome: true
        ),
        TransactionItem(
            title: "Makanan",
            source: "Bank BCA",
            note: "21 Jan 2026",
            amount: 10000,
            isIncome: false
        ),
        TransactionItem(
            title: "Tagihan",
            source: "Bank BCA",
            note: "21 Jan 2026",
            amount: 30500,
            isIncome: false
        ),
        TransactionItem(
            title: "Transport",
            source: "Bank BCA",
            note: "21 Jan 2026",
            amount: 200000,
            isIncome: false
        ),
        TransactionItem(
            title: "Makanan",
            source: "Bank BCA",
            note: "21 Jan 2026",
            amount: 100000,
            isIncome: false
        ),
        TransactionItem(
            title: "Gaji",
            source: "Bank BCA",
            note: "20 Jan 2026",
            amount: 10000000,
            isIncome: true
        )
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                TotalBalancedCard()
                IncomeExpenseSection()

                TransactionSectionView(
                    date: "Transaksi Terakhir",
                    transactions: transactions
                )
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
    }
}
