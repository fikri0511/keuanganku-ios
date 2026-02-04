//
//  DetailView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var dashboardVM: DashboardViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                headerSection

                Text("Riwayat Transaksi")
                    .font(.headline)

                ForEach(dashboardVM.lastTransactions) { trx in
                                    LastTransactionRow(transaction: trx)
                }


            }
            .padding()
        }
        .background(Color(.secondarySystemBackground))

    }

    // MARK: Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Detail Keuangan")
                .font(.title2)
                .bold()

            Text("Semua riwayat transaksi kamu")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
