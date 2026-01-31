//
//  WalletCardView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct WalletCardView: View{
    let title: String
    let amount: Double
    let icon: String
    let iconColor: Color
    
    var body: some View{
        VStack(alignment: .leading, spacing: 12){
            
            HStack{
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(iconColor)
                    .padding(8)
                    .background(iconColor.opacity(0.12))
                    .clipShape(Circle())
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)

            }
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
        Text("Rp \(Int(amount))")
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x:0, y: 4 )
    }
}
