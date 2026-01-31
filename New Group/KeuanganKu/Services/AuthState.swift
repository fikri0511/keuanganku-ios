//
//  AuthState.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import Foundation
import Combine

class AuthState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}
