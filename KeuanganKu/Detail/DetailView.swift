//
//  DetailView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dashboardVM: DashboardViewModel
    @EnvironmentObject var walletVM: WalletViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {

                headerSection
                    .padding(.horizontal, 16)

                // MARK: DOMPET SAYA
                VStack(spacing: 18) {

                    SectionTitle(title: "Dompet Saya")

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(walletVM.wallets) { wallet in
                            WalletGridCardView(wallet: wallet)
                        }
                    }
                }
                .padding(18)
                .background(sectionBackground)

                Divider()
                    .opacity(0.12)

                // MARK: RIWAYAT
                VStack(spacing: 16) {

                    SectionTitle(title: "Riwayat Transaksi")

                    let grouped = Dictionary(grouping: dashboardVM.lastTransactions) {
                        Calendar.current.startOfDay(for: $0.createdAt)
                    }

                    ForEach(grouped.keys.sorted(by: >), id: \.self) { day in
                        VStack(alignment: .leading, spacing: 14) {

                            Text(day.toDayHeader())
                                .font(.subheadline.bold())
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 6)

                            ForEach(grouped[day]!.sorted(by: { $0.createdAt > $1.createdAt })) { trx in
                                LastTransactionRow(transaction: trx)
                            }
                        }
                    }
                }
                .padding(18)
                .background(sectionBackground)
            }
            .padding(.horizontal)
            .padding(.bottom, 28)
        }
        .background(Color(.systemGroupedBackground))
        .task {
            if walletVM.wallets.isEmpty {
                await walletVM.loadWallets()
            }

            if dashboardVM.lastTransactions.isEmpty {
                await dashboardVM.loadData()
            }
        }
    }


    // MARK: Background card section (ga flat lagi)

    private var sectionBackground: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(
                LinearGradient(
                    colors: [
                        Color(.secondarySystemBackground),
                        Color(.secondarySystemBackground).opacity(0.96)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: .black.opacity(0.04), radius: 20, y: 10)
    }

    // MARK: Header

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Detail Keuangan")
                .font(.title2.bold())

            Text("Lihat dompet dan riwayat transaksi")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Rectangle()
                .fill(LinearGradient.appPrimary)
                .frame(width: 60, height: 3)
                .clipShape(Capsule())
                .padding(.top, 4)
        }
    }
}
