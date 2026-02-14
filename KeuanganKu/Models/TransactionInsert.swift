//
//  TransactionInsert.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//

import Foundation
struct TransactionInsert: Encodable {
    let amount: Double
    let type: String
    let wallet_id: UUID
    let category_id: UUID
    let note: String?
    let created_at: Date
}
