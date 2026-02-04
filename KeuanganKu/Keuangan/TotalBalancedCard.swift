//
//  TotalBalancedCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//
import SwiftUI

struct TotalBalancedCard: View {
    let total: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Total Uang")
                    .font(.caption2.bold())
                    .foregroundColor(.white.opacity(0.85))
                
                Text(total.toRupiah())
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundColor(.white)
                    .contentTransition(.numericText())

            }
            .padding(22)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.45, blue: 0.45),
                        Color(red: 0.02, green: 0.3, blue: 0.30)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 16, y: 10)
        }
    }
}
