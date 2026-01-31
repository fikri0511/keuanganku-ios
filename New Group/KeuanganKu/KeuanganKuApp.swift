//
//  KeuanganKuApp.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI
import Foundation

@main
struct KeuanganKuApp: App {
    @StateObject var authState = AuthState()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authState.isLoggedIn {
                    ContentView()
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                } else {
                    LoginView()
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.35), value: authState.isLoggedIn)
            .environmentObject(authState)
        }
    }
}
