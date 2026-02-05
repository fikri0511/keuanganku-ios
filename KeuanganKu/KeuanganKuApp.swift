//
//  KeuanganKuApp.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI
import Foundation
import Pulse
import PulseUI

@main
struct KeuanganKuApp: App {
    @StateObject var authState = AuthState()
    @StateObject var walletVM = WalletViewModel()
    @StateObject var dashboardVM = DashboardViewModel()

    var body: some Scene {
        WindowGroup {
            if authState.isLoggedIn {
                ContentView()
                    .environmentObject(walletVM)
                    .environmentObject(authState)
                    .environmentObject(dashboardVM)   // ✅ INI KUNCINYA
            } else {
                LoginView()
                    .environmentObject(authState)
            }
        }
    }
}
