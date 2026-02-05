//
//  WalletCardView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct WalletCardView: View {
    let wallet: Wallet

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // BARIS ATAS
            HStack(spacing: 8) {
                Image(systemName: SFSymbolMapper.map(wallet.icon))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(LinearGradient.appPrimary)
                    .frame(width: 28, height: 28)
                    .background(
                        LinearGradient.appPrimary.opacity(0.12)
                    )
                    .clipShape(Circle())

                Text(wallet.name)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)

                Spacer()

                Menu {
                    Button("Edit", systemImage: "pencil") {}
                    Button("Hapus", systemImage: "trash", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray.opacity(0.6))
                }
            }

            // NOMINAL
            Text("Rp \(Int(wallet.balance))")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(LinearGradient.appPrimary)
        }
        .padding(14)

        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.systemBackground))
        )

        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black.opacity(0.03), lineWidth: 1)
        )

        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
    }
}
