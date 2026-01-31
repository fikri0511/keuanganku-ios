//
//  TotalBalancedCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI
struct TotalBalancedCard: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius:20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.45, blue: 0.45),
                            Color(red: 0.05, green: 0.45, blue: 0.45)
                            ],
                        startPoint: .leading,
                        endPoint: .trailing
                        )
                    )
            VStack (alignment: .leading, spacing:20) {
                Text("Total Uang")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                
                Text("Rp 9.819.500")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.55, blue: 0.45),
                        Color(red: 0.02, green: 0.35, blue:0.30)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                    )
                )
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

