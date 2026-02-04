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
        VStack(alignment: .leading, spacing: 12) {

            HStack {
                Image(systemName: iconName)
                    .font(.title3)
                    .foregroundColor(.teal)
                    .padding(8)
                    .background(Color.teal.opacity(0.12))
                    .clipShape(Circle())

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(wallet.name)
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("Rp \(wallet.balance.formatted())")
                .font(.headline)
                .bold()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x:0, y: 4 )
    }

    private var iconName: String {
        switch wallet.name.lowercased() {
        case "gopay": return "iphone"
        case "bank bca": return "building.columns.fill"
        case "dompet cash": return "wallet.bifold.fill"
        default: return "creditcard"
        }
    }
}
