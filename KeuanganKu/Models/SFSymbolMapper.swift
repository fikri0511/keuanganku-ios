//
//  SFSymbolMapper.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 03/02/26.
//

import Foundation

struct SFSymbolMapper {

    static func map(_ name: String?) -> String {
        guard let name else { return "creditcard" }

        switch name.lowercased() {

        // dari category.icon di supabase
        case "briefcase":
            return "bag.fill"

        case "trendingup":
            return "chart.line.uptrend.xyaxis"

        case "forkknife", "fork.knife":
            return "fork.knife"

        case "car":
            return "car.fill"

        // dari wallet.icon
        case "banknote":
            return "banknote.fill"

        case "landmark":
            return "building.columns.fill"

        case "smartphone":
            return "iphone"

        default:
            return "creditcard"
        }
    }
}
