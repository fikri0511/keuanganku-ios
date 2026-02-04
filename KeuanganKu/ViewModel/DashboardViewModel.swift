//
//  DashboardViewModel.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import Foundation
import Combine
import Supabase

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var totalIncome: Double = 0
    @Published var totalExpense: Double = 0
    @Published var totalBalance: Double = 0
    @Published var lastTransactions: [TransactionItem] = []
    
    
    
    func loadData() async {
        do {
            let wallets = try await WalletService.shared.fetchWallets()
            let transactions = try await TransactionService.shared.fetchAllTransactions(limit: 10)
            
            lastTransactions = transactions
            
            totalBalance = wallets.reduce(0) { $0 + $1.balance }
            
            // Income & Expense cuma statistik
            totalIncome = transactions
                .filter { $0.type == "income" }
                .reduce(0) { $0 + $1.amount }

            totalExpense = transactions
                .filter { $0.type == "expense" }
                .reduce(0) { $0 + $1.amount }

            
        } catch {
            print("❌ DASHBOARD ERROR:", error)
        }
    }
}
