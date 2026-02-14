//
//  AturView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct AturView: View {
    
    @EnvironmentObject var authState: AuthState
    @State private var showLogoutAlert = false
    @State private var showTambahDompet = false
    @EnvironmentObject var walletVM: WalletViewModel
    @State private var showTambahKategori = false
    
    
    
    
    var body: some View {
        ZStack {
            
            Color(AppColor.bg)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    // HEADER
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pengaturan")
                            .font(.title2.bold())
                        
                        Text("Kelola dompet, kategori, dan data")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Rectangle()
                            .fill(LinearGradient.appPrimary)
                            .frame(width: 60, height: 3)
                            .clipShape(Capsule())
                            .padding(.top, 4)
                        
                        
                        
                        // CONTENT
                        VStack(spacing: 16) {
                            
                            // =========================
                            // AKUN CARD
                            // =========================
                            
                            VStack(alignment: .leading, spacing: 14) {
                                
                                HStack(spacing: 16) {
                                    
                                    Circle()
                                        .fill(AppColor.primary.opacity(0.15))
                                        .frame(width: 48, height: 48)
                                        .overlay(
                                            Image(systemName: "person.fill")
                                                .foregroundColor(AppColor.primary)
                                                .font(.system(size: 20))
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        Text("Akun")
                                            .font(.system(size: 13))
                                            .foregroundColor(.secondary)
                                        
                                        Text(authState.userName.isEmpty ? "-" : authState.userName)
                                            .font(.system(size: 16, weight: .semibold))
                                        
                                        Text(authState.userEmail)
                                            .font(.system(size: 13))
                                            .foregroundColor(.secondary)
                                        
                                        HStack(spacing: 6) {
                                            Text("ID: \(authState.userId)")
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                                .lineLimit(1)
                                                .truncationMode(.middle)
                                            
                                            Button {
                                                UIPasteboard.general.string = authState.userId
                                            } label: {
                                                Image(systemName: "doc.on.doc")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(AppColor.primary)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                
                                GradientOutlineButton(
                                    title: "Keluar Aplikasi",
                                    icon: "rectangle.portrait.and.arrow.right",
                                    isDestructive: true
                                ) {
                                    withAnimation {
                                        showLogoutAlert = true
                                    }
                                }
                            }
                            .padding(18)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                            )
                            .shadow(color: .black.opacity(0.04), radius: 6, y: 3)
                            
                            
                            // DOMPET
                            // DOMPET
                            SettingCard(
                                icon: "wallet.bifold.fill",
                                iconColor: AppColor.primary,
                                title: "Dompet",
                                subtitle: "Kelola dompet Anda"
                            ) {
                                GradientDashedButton(title: "Tambah Dompet Baru") {
                                    showTambahDompet = true
                                }
                            }
                            .sheet(isPresented: $showTambahDompet) {
                                TambahDompetView()
                                    .environmentObject(walletVM)
                            }
                            
                            
                            
                            
                            
                            // KATEGORI
                            SettingCard(
                                icon: "tag.fill",
                                iconColor: AppColor.primary,
                                title: "Kategori",
                                subtitle: "Kategori transaksi"
                            ) {
                                GradientDashedButton(title: "Tambah Kategori Baru") {
                                    showTambahKategori = true
                                }
                            }
                            .sheet(isPresented: $showTambahKategori) {
                                TambahKategoriView()
                            }
                            
                            
                            
                            // DATA
                            SettingCard(
                                icon: "trash.fill",
                                iconColor: .red,
                                title: "Data",
                                subtitle: "Reset semua data"
                            ) {
                                GradientOutlineButton(
                                    title: "Reset Semua Data",
                                    icon: "trash",
                                    isDestructive: true
                                ) {}
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        
                        // FOOTER
                        VStack(spacing: 2) {
                            Text("KeuanganKu v1.0")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Text("Personal Finance Tracker")
                                .font(.caption)
                                .foregroundColor(.secondary.opacity(0.7))
                        }
                        .padding(.vertical, 20)
                    }
                }
                
                
                // =========================
                // LOGOUT ALERT POPUP
                // =========================
                
                if showLogoutAlert {
                    
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                showLogoutAlert = false
                            }
                        }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        HStack(spacing: 8) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            
                            Text("Keluar dari Aplikasi?")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.red)
                        }
                        
                        Text("Apakah Anda yakin ingin keluar dari aplikasi KeuanganKu?")
                            .font(.system(size: 14))
                        
                        Text("Anda dapat login kembali kapan saja menggunakan email dan password Anda.")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 12) {
                            
                            Spacer()
                            
                            // BATAL (abu-abu)
                            Button {
                                withAnimation {
                                    showLogoutAlert = false
                                }
                            } label: {
                                Text("Batal")
                                    .font(.system(size: 14, weight: .medium))
                                    .padding(.horizontal, 18)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.gray.opacity(0.15))
                                    )
                                    .foregroundColor(.gray)
                            }
                            
                            // YA KELUAR (merah)
                            Button {
                                withAnimation {
                                    showLogoutAlert = false
                                }
                                Task {
                                    await authState.logout()
                                }
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Ya, Keluar")
                                }
                                .font(.system(size: 14, weight: .medium))
                                .padding(.horizontal, 18)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.red)
                                )
                                .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                    )
                    .padding(.horizontal, 30)
                    .transition(.scale)
                }
            }
            .sheet(isPresented: $showTambahKategori) {
                TambahKategoriView()
            }
        }
        
    }
    struct PressGradientButton: ButtonStyle {
        
        var cornerRadius: CGFloat = 12
        var height: CGFloat = 44
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(configuration.isPressed ? .white : .black)
                .frame(height: height)
                .frame(minWidth: 110)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(
                            configuration.isPressed
                            ? AnyShapeStyle(LinearGradient.appPrimary)
                            : AnyShapeStyle(Color.gray.opacity(0.12))
                        )
                )
                .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}
