//
//  AuthState.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import Combine
import Supabase
import Foundation



@MainActor
final class AuthState: ObservableObject {

    @Published var isLoggedIn = false
    @Published var userId: String = ""
    @Published var userEmail: String = ""
    @Published var userName: String = ""
    
    

    private var client: SupabaseClient {
        SupabaseConfig.shared.client
    }

    init() {
        Task {
            await loadSession()
        }
    }

    // MARK: - Load Session & User
    func loadSession() async {
        do {
            let session = try await client.auth.session
            let user = session.user

            isLoggedIn = true
            userId = user.id.uuidString
            userEmail = user.email ?? ""

            // Ambil nama dari metadata (kalau ada)
            if let name = user.userMetadata["full_name"]?.stringValue {
                userName = name
            } else {
                userName = userEmail.components(separatedBy: "@").first ?? ""
            }

        } catch {
            isLoggedIn = false
            userId = ""
            userEmail = ""
            userName = ""
        }
    }

    func logout() async {
        try? await client.auth.signOut()
        isLoggedIn = false
        userId = ""
        userEmail = ""
        userName = ""
    }
}
