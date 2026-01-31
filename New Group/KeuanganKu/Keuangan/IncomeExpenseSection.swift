//
//  IncomeExpenseSection.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct IncomeExpenseSection: View{
    var body: some View{
        HStack(spacing: 16){
            SmallCard(
                title: "Pemasukan",
                amount: "Rp 10.010.000",
                color: .green
                )
            
            SmallCard(
                title: "Pengeluaran",
                amount: "Rp 390.500",
                color: .red
                )
        }
    }
}

struct SmallCard: View{
    let title: String
    let amount: String
    let color: Color
    
    var body: some View{
        VStack(alignment: .leading, spacing: 8){
            Text(title)
                .font(.caption)
                .foregroundColor(color)
            
            Text(amount)
                .bold()
                .foregroundColor(color)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [
                    color.opacity(0.15),
                    color.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
            )
        .cornerRadius(16)
    }
}

