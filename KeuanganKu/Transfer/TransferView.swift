//
//  TransferView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct TransferView: View {

    @EnvironmentObject var walletVM: WalletViewModel

    @State private var fromWallet: Wallet?
    @State private var toWallet: Wallet?
    @State private var amount: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                headerSection

                WalletTransferCard(
                    fromWallet: $fromWallet,
                    toWallet: $toWallet,
                    wallets: walletVM.wallets
                )

                TransferAmountCard(amount: $amount)

                TransferDateCard()

                transferButton
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(Color(.secondarySystemBackground))
        .task {
            await walletVM.loadWallets()
        }

        .onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 6) {
            Text("Transfer Antar Dompet")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Pindahkan uang antar dompet Anda")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.top, 32)
        .padding(.bottom, 12)
    }

    // MARK: - Button
    private var transferButton: some View {
        Button("Transfer Sekarang") {
            print("From:", fromWallet?.name ?? "")
            print("To:", toWallet?.name ?? "")
            print("Amount:", amount)
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.55, blue: 0.45),
                    Color(red: 0.02, green: 0.35, blue: 0.30)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(14)
    }
}
