//
//  SectionTitle.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 05/02/26.
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    
    var body: some View {
        HStack(spacing: 10) {
            Rectangle()
                .fill(LinearGradient.appPrimary)
                .frame(width: 4, height: 18)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            
            Text(title)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

