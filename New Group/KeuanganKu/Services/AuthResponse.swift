//
//  AuthResponse.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//
import Foundation

nonisolated struct AuthResponse: Codable, Sendable {
    let access_token: String
    let refresh_token: String
}
