//
//  RootView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct RootView: View {

    @State private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
