//
//  LoginView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI

struct LoginView: View {

    // MARK: - State
    
    @EnvironmentObject var authState: AuthState 
    @State private var email = ""
    @State private var password = ""
    @State private var selectedTab: AuthTab = .login
    @State private var isLoading = false


    @FocusState private var focusedField: Field?

    enum Field {
        case email
        case password
    }

    // MARK: - Theme
    private let primaryGradient = LinearGradient(
        colors: [
            Color(red: 0.05, green: 0.55, blue: 0.45),
            Color(red: 0.02, green: 0.35, blue: 0.30)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    private let grayGradient = LinearGradient(
        colors: [.gray, .gray],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(.white),
               
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                loginCard
                    .frame(maxWidth: 420)

                Spacer()

                Text("Versi 1.0")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.horizontal, 20)
        }
    }


    // MARK: - Card
    private var loginCard: some View {
        VStack(spacing: 22) {

            headerSection
            authTabSection

            if selectedTab == .login {
                loginForm
            } else {
                RegisterView()
            }

            footerSection
        }
        .padding(24)
        .background(GlassBackground())

    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 12) {

            HStack(spacing: 10) {
                Image(systemName: "wallet.bifold")
                    .font(.title2)
                    .foregroundStyle(primaryGradient)

                Text("KeuanganKu")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(primaryGradient)
            }

            Text("Kelola keuanganmu dengan mudah dan cepat")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Tab
    private var authTabSection: some View {
        HStack(spacing: 4) {
            tabItem("Masuk", selectedTab == .login) {
                selectedTab = .login
            }
            tabItem("Daftar", selectedTab == .register) {
                selectedTab = .register
            }
        }
        .padding(4)
        .background(Color(.systemGray5))
        .cornerRadius(14)
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: selectedTab)
    }

    // MARK: - Login Form
    private var loginForm: some View {
        VStack(spacing: 16) {
            
            inputField(
                title: "Email atau Username",
                placeholder: "email@example.com atau username",
                text: $email,
                field: .email
            )
            
            inputField(
                title: "Password",
                placeholder: "Password",
                text: $password,
                secure: true,
                field: .password
            )
            
            Button {
                isLoading = true
                
                AuthService.shared.login(email: email, password: password) { result in
                    DispatchQueue.main.async {
                        isLoading = false
                        
                        switch result {
                        case .success(let auth):
                            print("TOKEN:", auth.access_token)
                            authState.isLoggedIn = true
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
            } label: {
                ZStack {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Masuk")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .background(primaryGradient)
            .cornerRadius(14)
            .buttonStyle(SoftButtonStyle())
            
            dividerSection

            Button("Masuk sebagai Tamu") {}
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .buttonStyle(SoftButtonStyle())

        }
    }

    // MARK: - Input Field
    private func inputField(
        title: String,
        placeholder: String,
        text: Binding<String>,
        secure: Bool = false,
        field: Field
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Group {
                if secure {
                    SecureField(placeholder, text: text)
                } else {
                    TextField(placeholder, text: text)
                }
            }
            .focused($focusedField, equals: field)
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        focusedField == field
                            ? primaryGradient
                            : grayGradient,
                        lineWidth: 1.2
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: focusedField)
        }
    }

    // MARK: - Divider
    private var dividerSection: some View {
        HStack(spacing: 12) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray4))
                .frame(maxWidth: 70)

            Text("ATAU")
                .font(.caption)
                .foregroundColor(.gray)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray4))
                .frame(maxWidth: 70)
        }
    }

    // MARK: - Footer
    private var footerSection: some View {
        Text("© 2026 KeuanganKu App")
            .font(.caption2)
            .foregroundColor(.gray)
    }

    // MARK: - Tab Item
    private func tabItem(
        _ title: String,
        _ active: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(active ? primaryGradient : grayGradient)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(active ? Color.white : Color.clear)
                .cornerRadius(10)
        }
    }
}

import SwiftUI

struct GlassBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 24, style: .continuous)
            .fill(.ultraThinMaterial)          // 🔥 efek glass
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 30, y: 20)
    }
}
