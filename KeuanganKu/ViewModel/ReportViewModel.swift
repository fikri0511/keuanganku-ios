//
//  ReportViewModel.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 04/02/26.
//

import Foundation
import Combine

@MainActor
final class ReportViewModel: ObservableObject {
    @Published var weeklyExpenses: [WeeklyExpense] = []
    
    func loadWeekly() async {
        do {
            weeklyExpenses = try await ReportService.shared.fetchLast7DaysExpenses()
        } catch {
            print("Failed load weekly:", error)
        }
    }
}
