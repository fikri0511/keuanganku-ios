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
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 8) {

                Image(systemName: SFSymbolMapper.map(wallet.icon))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(LinearGradient.appPrimary)
                    .frame(width: 30, height: 30)
                    .background(
                        LinearGradient.appPrimary.opacity(0.12)
                    )
                    .clipShape(Circle())

                Text(wallet.name)
                    .font(.system(size: 13, weight: .semibold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.85)
                    .multilineTextAlignment(.leading)
                    .layoutPriority(1)


                Spacer()

                Image(systemName: "ellipsis")
                    .foregroundColor(.gray.opacity(0.6))
            }

            Text(wallet.balance.toRupiah())
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(LinearGradient.appPrimary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
        )
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
    }
}
