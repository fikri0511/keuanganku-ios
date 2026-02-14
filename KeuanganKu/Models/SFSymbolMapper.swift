//
//  SFSymbolMapper.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 03/02/26.
//

struct SFSymbolMapper {

    static func map(_ name: String?) -> String {
        guard let name else { return "creditcard" }

        switch name.lowercased() {

        // ======================
        // WALLET ICONS (WEB)
        // ======================

        case "wallet":
            return "wallet.bifold.fill"

        case "landmark":
            return "building.columns.fill"

        case "smartphone":
            return "iphone"

        case "creditcard":
            return "creditcard.fill"

        case "banknote":
            return "banknote.fill"

        case "piggybank":
            return "poweroutlet.type.h.square.fill"

        case "building":
            return "building.2.fill"

        case "dollarsign":
            return "dollarsign.circle.fill"


        // ======================
        // CATEGORY ICONS (WEB)
        // ======================

        case "briefcase":
            return "briefcase.fill"

        case "laptop":
            return "laptopcomputer"

        case "trendingup":
            return "chart.line.uptrend.xyaxis"

        case "gift":
            return "gift.fill"

        case "utensilscrossed":
            return "fork.knife"

        case "car":
            return "car.fill"

        case "shoppingcart":
            return "cart.fill"

        case "filetext":
            return "doc.text.fill"

        case "film":
            return "film.fill"

        case "heart":
            return "heart.fill"

        case "home":
            return "house.fill"

        case "zap":
            return "bolt.fill"

        case "coffee":
            return "cup.and.saucer.fill"

        case "shoppingbag":
            return "bag.fill"


        // ======================
        // LEGACY / BACKWARD
        // ======================

        case "utensils":
            return "fork.knife"

        case "shopping":
            return "cart.fill"

        case "transport":
            return "car.fill"

        case "salary":
            return "banknote.fill"

        case "phone":
            return "iphone"

        case "bank":
            return "building.columns.fill"

        case "keranjang":
            return "basket"

        default:
            return "creditcard"
        }
    }
}
