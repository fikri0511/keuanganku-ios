//
//  WalletViewModel.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//

import Foundation
import Combine

@MainActor
final class WalletViewModel: ObservableObject {

    @Published var wallets: [Wallet] = []

    func loadWallets() async {
        do {
            wallets = try await WalletService.shared.fetchWallets()
        } catch {
            print("Wallet load error:", error)
        }
    }

    func addWallet(name: String, balance: Double, icon: String) async throws {
        try await WalletService.shared.createWallet(
            name: name,
            balance: balance,
            icon: icon
        )
        await loadWallets()
    }
}
