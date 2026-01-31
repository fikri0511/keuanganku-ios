//
//  WalletGridView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 28/01/26.
//

import SwiftUI

struct WalletGridView: View{
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View{
        LazyVGrid(columns: columns, spacing: 16){
            
            
            WalletCardView(
                title: "Bank BCA",
                amount: 9_609_500,
                icon: "building.columns.fill",
                iconColor: .blue
            )
          
            
            WalletCardView(
                           title: "Dompet Cash",
                           amount: 0,
                           icon: "wallet.bifold",
                           iconColor: .green
                       )
            WalletCardView(
                title: "Gopay",
                amount: 110_000,
                icon: "wallet.bifold.fill",
                iconColor: .teal
                )

                     

            }
        }
    }

