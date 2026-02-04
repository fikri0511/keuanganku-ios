//
//  CategoryExpense.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct CategoryExpense: Identifiable{
    let id = UUID()
    let name: String
    let amount: Int
    let color: Color
    let percantage: Double
}
