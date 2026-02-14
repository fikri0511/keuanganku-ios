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
    @StateObject var categoryVM = CategoryViewModel()
    
    

    var body: some Scene {
        WindowGroup {
            if authState.isLoggedIn {
                ContentView()
                    .environmentObject(walletVM)
                    .environmentObject(authState)
                    .environmentObject(dashboardVM)
                    .environmentObject(categoryVM) // ✅ TAMBAH INI
            } else {
                LoginView()
                    .environmentObject(authState)
            }
        }
    }
}
