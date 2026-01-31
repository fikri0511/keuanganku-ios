//
//  DetailView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                headerSection
                walletSection
                transactionSection
                
            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Detail Keuangan")
                .font(.title2)
                .bold()
            
            Text("Lihat dompet dan riwayat transaksi")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    // MARK: - Wallet
    private var walletSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Dompet Saya")
                .font(.headline)
            
            
            
            
            WalletGridView()
        }
    }
    
    // MARK: - Transaction
    private var transactionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Riwayat Transaksi")
                .font(.headline)
            
            TransactionSectionView(
                date: "22 Januari 2026",
                transactions: [
                    TransactionItem(
                        title: "Makanan",
                        source: "Bank BCA",
                        note: "makan gilak",
                        amount: 50_000,
                        isIncome: false
                    )
                ]
            )
            
          TransactionSectionView(
                date: "21 Januari 2026",
                transactions: [
                    TransactionItem(
                        title: "Gaji",
                        source: "GoPay",
                        note: "",
                        amount: 10_000,
                        isIncome: true
                    ),
                    
                    TransactionItem(
                        title: "Makanan",
                        source: "Bank BCA",
                        note: "",
                        amount: 10_000,
                        isIncome: false
                        ),
                    
                    TransactionItem(
                        title: "Tagihan",
                        source: "Bank BCA",
                        note: "",
                        amount: 30_500,
                        isIncome: false
                    ),
                    
                    TransactionItem(
                        title: "Transport",
                        source: "Bank BCA",
                        note: "",
                        amount: 200_000,
                        isIncome: false
                        ),
                    
                    TransactionItem(
                        title: "Makanan",
                        source: "Bank BCA",
                        note: "",
                        amount: 100_000,
                        isIncome: false
                        )
                    ]
                )
                
                TransactionSectionView(
                      date: "20 Januari 2026",
                      transactions: [
                    TransactionItem(
                        title: "Gaji",
                        source: "Bank BCA",
                        note: "",
                        amount: 10_000_000,
                        isIncome: true
                        )
                        ]
                      
                    )
            
    
        }
    }
}
