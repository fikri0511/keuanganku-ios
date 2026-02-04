//
//  AuthService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//
import Supabase
import Foundation

final class AuthService {
    static let shared = AuthService()

    private var client: SupabaseClient {
        SupabaseConfig.shared.client
    }

    func currentUserId() async throws -> UUID {
        let session = try await client.auth.session
        return session.user.id
    }
}
