//
//  ContentView.swift
//  Keuanganku
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct KeuanganView: View {

    @EnvironmentObject var walletVM: WalletViewModel
    @EnvironmentObject var dashboardVM: DashboardViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {

            VStack(spacing: 32) {

                // MARK: FLOATING HEADER (Apple Wallet style)
                ZStack {
                    RoundedRectangle(cornerRadius: 32, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(Color.white.opacity(0.6), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.08), radius: 20, y: 10)

                    VStack(spacing: 20) {
                        TotalBalancedCard(total: dashboardVM.totalBalance)

                        IncomeExpenseSection(
                            income: dashboardVM.totalIncome,
                            expense: dashboardVM.totalExpense
                        )
                    }
                    .padding(20) // padding pindah ke isi, bukan ngecilin lebar
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // MARK: TRANSACTION SECTION (lower layer)
                VStack(alignment: .leading, spacing: 16) {

                    Text("Transaksi Terakhir")
                        .font(.title3.weight(.semibold))
                        .padding(.horizontal, 24)

                    VStack(spacing: 14) {
                        ForEach(dashboardVM.lastTransactions) { trx in
                            if trx.type != "transfer" {
                                LastTransactionRow(transaction: trx)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .background(Color(.systemGroupedBackground))
                .padding(.top, 8)
            }
            .padding(.bottom, 40)
        }
        .background(
            LinearGradient(
                colors: [
                    Color(.systemGroupedBackground),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        
        .overlay(alignment: .bottomTrailing) {
            Button {
                // add transaksi
            } label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(LinearGradient.appPrimary)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
            .padding(24)
        }

        .task {
            await dashboardVM.loadData()
            await walletVM.loadWallets()
        }
    }
}
