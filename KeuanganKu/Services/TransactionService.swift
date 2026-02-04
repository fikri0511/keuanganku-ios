//
//  TransactionService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import Foundation
import Supabase

final class TransactionService {
    static let shared = TransactionService()

    func fetchAllTransactions(limit: Int? = nil) async throws -> [TransactionItem] {
        let client = SupabaseConfig.shared.client
        let session = try await client.auth.session

        var components = URLComponents(
            string: "https://qhrgpwycpnjtepntjdyn.supabase.co/functions/v1/supabase-functions-transaction-feed"
        )!

        if let limit {
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        print("RAW JSON:", String(data: data, encoding: .utf8)!)

        // ⚠️ Decode langsung array
        return try JSONDecoder().decode([TransactionItem].self, from: data)
    }
}
