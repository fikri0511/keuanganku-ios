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
            print("✅ WALLET COUNT:", wallets.count)
        } catch {
            print("❌ WALLET ERROR:", error)
        }
    }

}
