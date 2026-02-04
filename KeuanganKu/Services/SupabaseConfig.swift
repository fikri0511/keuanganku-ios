//
//  SupabaseConfig.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 02/02/26.
//

import Supabase
import Foundation
final class SupabaseConfig {
    static let shared = SupabaseConfig()

    let client = SupabaseClient(
        supabaseURL: URL(string: "https://qhrgpwycpnjtepntjdyn.supabase.co")!,
        supabaseKey: "sb_publishable_3E6A7qqqIcVV_oiHJf8niw_z8XtGv82"
    )
}
