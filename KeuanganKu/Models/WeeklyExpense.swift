//
//  WeeklyExpense.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct WeeklyExpense: Identifiable{
    let id = UUID()
    let day: String
    let amount: Double
}
