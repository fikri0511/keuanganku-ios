//
//  TransferService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 13/02/26.
//


import Supabase
import Foundation


final class TransferService {

    static let shared = TransferService()

    func createTransfer(
        amount: Double,
        sourceWalletId: UUID,
        destinationWalletId: UUID,
        note: String?,
        date: Date
    ) async throws {

        if sourceWalletId == destinationWalletId {
            throw NSError(domain: "", code: 400, userInfo: [
                NSLocalizedDescriptionKey: "Dompet tidak boleh sama"
            ])
        }

        let client = SupabaseConfig.shared.client

        try await client
            .from("transactions")
            .insert([
                [
                    "type": "transfer",
                    "amount": String(amount),
                    "wallet_id": sourceWalletId.uuidString,
                    "destination_wallet_id": destinationWalletId.uuidString,
                    "category_id": nil,
                    "note": note,
                    "date": ISO8601DateFormatter().string(from: date)
                ]
            ])
            .execute()

    }
}
