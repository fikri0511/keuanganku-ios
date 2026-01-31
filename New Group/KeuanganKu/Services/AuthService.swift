//
//  AuthService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import Foundation



class AuthService {
    
    static let shared = AuthService()
    
    private let baseURL = "https://rwjppdpykegjwgaipbdp.supabase.co"
    private let apiKey = "sb_publishable_2Lj0xctI9Fsh7OlSzJiV3w_TAhXcRbK"
    
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/auth/v1/token?grant_type=password") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(error ?? URLError(.badServerResponse)))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()

    }
}
