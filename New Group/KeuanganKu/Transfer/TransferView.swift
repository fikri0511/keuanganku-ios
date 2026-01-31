//
//  TransferView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct TransferView: View {

    @State private var fromWallet: WalletType?
    @State private var toWallet: WalletType?
    @State private var amount: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                headerSection

                walletTransferCard

                TransferAmountCard(amount: $amount)

                TransferDateCard()

                transferButton
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .background(Color(.secondarySystemBackground))
        // 👇 TAP DI LUAR = UNFOCUS
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

    // MARK: - Wallet Card
    private var walletTransferCard: some View {
        VStack(spacing: 0) {

            walletSection(
                title: "Dari Dompet",
                selected: $fromWallet,
                blocked: toWallet
            )

            VStack {
                Spacer(minLength: 12)
                arrowIndicator
                Spacer(minLength: 12)
            }

            walletSection(
                title: "Ke Dompet",
                selected: $toWallet,
                blocked: fromWallet
            )
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }

    private func walletSection(
        title: String,
        selected: Binding<WalletType?>,
        blocked: WalletType?
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(WalletType.allCases, id: \.self) { wallet in
                    WalletItemCard(
                        wallet: wallet,
                        amount: wallet.amount,
                        isSelected: selected.wrappedValue == wallet,
                        isBlocked: blocked == wallet
                    ) {
                        if selected.wrappedValue == wallet {
                            selected.wrappedValue = nil
                        } else if blocked != wallet {
                            selected.wrappedValue = wallet
                        }
                    }
                }
            }
        }
    }

    // MARK: - Arrow
    private var arrowIndicator: some View {
        Image(systemName: "arrow.right")
            .font(.title3)
            .foregroundColor(Color(red: 0.05, green: 0.55, blue: 0.45))
            .frame(width: 44, height: 44)
            .background(
                Circle()
                    .fill(Color(red: 0.05, green: 0.55, blue: 0.45).opacity(0.15))
            )
    }

    // MARK: - Button
    private var transferButton: some View {
        Button("Transfer Sekarang") {}
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
