//
//  WalletTransferCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct WalletTransferCard: View {

    @Binding var fromWallet: WalletType?
    @Binding var toWallet: WalletType?

    var body: some View {
        VStack(spacing: 20) {

            section(
                title: "Dari Dompet",
                selected: $fromWallet,
                blocked: toWallet
            )

            arrow()

            section(
                title: "Ke Dompet",
                selected: $toWallet,
                blocked: fromWallet
            )
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 6, y: 3)
    }

    private func section(
        title: String,
        selected: Binding<WalletType?>,
        blocked: WalletType?
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)

            HStack(spacing: 12) {
                ForEach(WalletType.allCases, id: \.self) { wallet in
                    WalletItemCard(
                        wallet: wallet,
                        amount: dummyAmount(wallet),
                        isSelected: selected.wrappedValue == wallet,
                        isBlocked: blocked == wallet
                    ) {
                        // cancel kalau pencet ulang
                        if selected.wrappedValue == wallet {
                            selected.wrappedValue = nil
                        }
                        // select kalau bukan wallet yg diblok
                        else if blocked != wallet {
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

    private func dummyAmount(_ wallet: WalletType) -> Int {
        switch wallet {
        case .gopay: return 100_000
        case .bca: return 250_000
        case .cash: return 0
        }
    }
}
