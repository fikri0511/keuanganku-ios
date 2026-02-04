//
//  AuthState.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import Combine
import Supabase

@MainActor
final class AuthState: ObservableObject {

    @Published var isLoggedIn = false

    private var client: SupabaseClient {
        SupabaseConfig.shared.client
    }

    init() {
        Task {
            await checkSession()
        }
    }

    func checkSession() async {
        do {
            _ = try await client.auth.session
            isLoggedIn = true
        } catch {
            isLoggedIn = false
        }
    }

    func logout() async {
        try? await client.auth.signOut()
        isLoggedIn = false
    }
}
