//
//  CategoryService.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//

import Foundation
import Supabase

final class CategoryService {

    static let shared = CategoryService()
    private let client = SupabaseConfig.shared.client

    struct CategoryInsert: Encodable {
        let name: String
        let icon: String
        let color: String
        let type: String
    }

    // 🔹 CREATE
    func createCategory(
        name: String,
        icon: String,
        color: String,
        type: String
    ) async throws {

        let category = CategoryInsert(
            name: name,
            icon: icon,
            color: color,
            type: type
        )

        try await client
            .from("categories")
            .insert(category)
            .execute()
    }

    // 🔹 FETCH
    func fetchCategories() async throws -> [Category] {

        let response = try await client
            .from("categories")
            .select()
            .order("created_at", ascending: false)
            .execute()

        let data = response.data

        return try JSONDecoder().decode([Category].self, from: data)
    }
}
