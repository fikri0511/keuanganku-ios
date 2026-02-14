//
//  CategoryViewModel.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//

import Foundation
import Combine
@MainActor
final class CategoryViewModel: ObservableObject {

    @Published var categories: [Category] = []
    @Published var isLoading = false

    func loadCategories() async {
        isLoading = true

        do {
            categories = try await CategoryService.shared.fetchCategories()
        } catch {
            print("❌ LOAD CATEGORY ERROR:", error)
        }

        isLoading = false
    }
}
