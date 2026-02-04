//
//  WalletItemCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct WalletItemCard: View {

    let id: String
       let name: String
       let balance: Int
       let isSelected: Bool
       let isBlocked: Bool
       let onTap: () -> Void

    private let gradient = LinearGradient(
        colors: [
            Color(red: 0.05, green: 0.55, blue: 0.45),
            Color(red: 0.02, green: 0.35, blue: 0.30)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        VStack(spacing: 6) {

            Image(systemName: iconName)
                .font(.title3)
                .foregroundColor(isSelected ? .clear : .gray)
                .overlay(
                    Group {
                        if isSelected {
                            Image(systemName: iconName)
                                .font(.title3)
                                .foregroundStyle(gradient)
                        }
                    }
                )

            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .clear : .primary)
                .overlay(
                    Group {
                        if isSelected {
                            Text(name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(gradient)
                        }
                    }
                )

            Text("Rp \(balance.formatted())")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.white)
        .overlay(
            Group {
                if isSelected {
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(gradient, lineWidth: 1.5)
                } else {
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                }
            }
        )
        .cornerRadius(14)
        .opacity(isBlocked ? 0.4 : 1)
        .onTapGesture {
            if !isBlocked { onTap() }
        }
    }

    private var iconName: String {
        switch name.lowercased() {
        case "gopay": return "iphone"
        case "bank bca": return "building.columns"
        case "dompet cash": return "wallet.pass"
        default: return "creditcard"
        }
    }
}
