//
//  IncomeExpenseSection.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct IncomeExpenseSection: View {
    let income: Double
    let expense: Double
    
    var body: some View {
        HStack(spacing: 16) {
            summaryCard(
                title: "Pemasukan",
                amount: income,
                color: .green,
                icon: "chart.line.uptrend.xyaxis"
            )
            
            summaryCard(
                title: "Pengeluaran",
                amount: expense,
                color: .red,
                icon: "chart.line.downtrend.xyaxis"
            )
        }
    }
    
    private func summaryCard(
        title: String,
        amount: Double,
        color: Color,
        icon: String
    ) -> some View {
        
        HStack(spacing: 12) {
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(spacing: 8) {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(color)
                        .padding(8)
                        .background(color.opacity(0.15))
                        .clipShape(Circle())
                    
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(color)
                        .lineLimit(1)              // ⬅️ jangan boleh turun
                        .minimumScaleFactor(0.5)  // ⬅️ mengecil kalau perlu

                }
                
                Text(amount, format: .currency(code: "IDR"))
                    .font(.system(size: 22, weight: .bold)) // dibesarin dikit
                    .foregroundStyle(color)
                    .lineLimit(1)                 // ⬅️ WAJIB
                    .minimumScaleFactor(0.7)     // ⬅️ WAJIB
            }
            
            Spacer()
        }
        .padding(16)
        .frame(height: 110)
        .background(
            LinearGradient(
                colors: [
                    color.opacity(0.18),
                    color.opacity(0.06)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(color.opacity(0.6), lineWidth: 1.5)
        )
    }
}
