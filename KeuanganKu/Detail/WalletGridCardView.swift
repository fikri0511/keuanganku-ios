//
//  WalletGridCardView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 04/02/26.
//

import SwiftUI

struct WalletGridCardView: View {
    let wallet: Wallet

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack(spacing: 10) {

                Image(systemName: SFSymbolMapper.map(wallet.icon))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(LinearGradient.appPrimary)
                    .frame(width: 32, height: 32)
                    .background(
                        LinearGradient.appPrimary.opacity(0.12)
                    )
                    .clipShape(Circle())

                Text(wallet.name)
                    .font(.system(size: 13, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .layoutPriority(1)

                Menu {
                    Button("Edit", systemImage: "pencil") {}
                    Button("Hapus", systemImage: "trash", role: .destructive) {}
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray.opacity(0.6))
                }
            }

            Text(wallet.balance.toRupiah())
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(LinearGradient.appPrimary)
        }
        .padding(18)
        .frame(height: 105)
        .background {
            RoundedRectangle(cornerRadius: 22)
                .fill(.white)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(.white.opacity(0.6), lineWidth: 1)
                .blendMode(.overlay)
        )
        .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 8)
    }
}
