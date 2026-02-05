//
//  ReportService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 04/02/26.
//

import Supabase
import Foundation


final class ReportService {
    static let shared = ReportService()

    func fetchLast7DaysExpenses() async throws -> [WeeklyExpense] {
        let client = SupabaseConfig.shared.client
        let user = try await client.auth.session.user

        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date())!

        // 🔥 format tanggal untuk Postgres
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateString = formatter.string(from: sevenDaysAgo)

        // 🔥 HIT SUPABASE DULU
        let response = try await client
            .from("transactions")
            .select("amount, created_at")
            .eq("user_id", value: user.id)
            .gte("created_at", value: dateString)
            .execute()

        // 🔥 baru decode
        struct Row: Decodable {
            let amount: Double
            let created_at: Date
        }

        let rows = try JSONDecoder().decode([Row].self, from: response.data)

        // 🔥 group per hari
        let grouped = Dictionary(grouping: rows) { row in
            let df = DateFormatter()
            df.locale = Locale(identifier: "id_ID")
            df.dateFormat = "E"
            return df.string(from: row.created_at)
        }

        return grouped.map { key, value in
            WeeklyExpense(
                day: key,
                amount: value.reduce(0) { $0 + $1.amount }
            )
        }
        .sorted { $0.day < $1.day }
    }
}
