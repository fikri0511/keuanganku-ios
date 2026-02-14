//
//  Wallet.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import SwiftUI

struct Wallet: Decodable, Identifiable {
    let id: UUID
    let name: String
    let balance: Double
    let icon: String?  
}
