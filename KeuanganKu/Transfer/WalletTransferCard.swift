//
//  WalletTransferCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct WalletTransferCard: View {

    @Binding var fromWallet: Wallet?
    @Binding var toWallet: Wallet?

    let wallets: [Wallet]

    var body: some View {
        VStack(spacing: 20) {

            section(title: "Dari Dompet", selected: $fromWallet, blocked: toWallet)
            arrow()
            section(title: "Ke Dompet", selected: $toWallet, blocked: fromWallet)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
    }

    private func section(
        title: String,
        selected: Binding<Wallet?>,
        blocked: Wallet?
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible()), count: 3),
                spacing: 12
            ) {
                ForEach(wallets, id: \.id) { wallet in
                    WalletItemCard(
                        id: wallet.id,
                        name: wallet.name,
                        balance: Int(wallet.balance),
                        isSelected: selected.wrappedValue?.id == wallet.id,
                        isBlocked: blocked?.id == wallet.id
                    ) {
                        if selected.wrappedValue?.id == wallet.id {
                            selected.wrappedValue = nil
                        } else if blocked?.id != wallet.id {
                            selected.wrappedValue = wallet
                        }
                    }
                }
            }
        }
    }

    private func arrow() -> some View {
        Image(systemName: "arrow.right")
            .padding(12)
            .background(Color.teal.opacity(0.12))
            .clipShape(Circle())
    }
}
