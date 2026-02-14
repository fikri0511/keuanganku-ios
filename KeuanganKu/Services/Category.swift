//
//  Category.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//


import Foundation

struct Category: Identifiable, Codable {
    let id: UUID
    let name: String
    let icon: String
    let color: String
    let type: String
}
