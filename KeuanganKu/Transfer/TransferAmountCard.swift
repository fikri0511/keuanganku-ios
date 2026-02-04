//
//  TransferAmountCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct TransferAmountCard: View {

    @Binding var amount: Int
    @FocusState private var isFocused: Bool

    private let activeGreen = Color(red: 0.05, green: 0.55, blue: 0.45)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Jumlah Transfer")
                .font(.subheadline)
                .fontWeight(.semibold)

            HStack {

                Text("Rp")
                    .foregroundColor(.gray)

                TextField("0", value: $amount, format: .number)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .frame(maxWidth: .infinity)

                // 👇 PANAH MUNCUL SAAT AKTIF
                if isFocused {
                    VStack(spacing: 6) {

                        Button {
                            amount += 1
                        } label: {
                            Image(systemName: "chevron.up")
                                .font(.caption)
                        }

                        Button {
                            if amount > 0 { amount -= 1 }
                        } label: {
                            Image(systemName: "chevron.down")
                                .font(.caption)
                        }
                    }
                    .foregroundColor(activeGreen)
                    .transition(.opacity)
                }
            }
            .padding()
            .background(
                isFocused
                ? activeGreen.opacity(0.06)
                : Color(.systemBackground)
            )
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isFocused ? activeGreen : Color(.systemGray4),
                        lineWidth: 1.5
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
    }
}
