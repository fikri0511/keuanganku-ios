//
//  LoginViewModel.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//
import Foundation
import Supabase
import Combine

@MainActor
class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var client: SupabaseClient {
        SupabaseConfig.shared.client
    }

    func login(authState: AuthState) {
        Task {
            do {
                isLoading = true

                try await client.auth.signIn(
                    email: email,
                    password: password
                )

                authState.isLoggedIn = true
                isLoading = false

            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }
}
