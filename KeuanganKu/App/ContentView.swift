//
//  ContentView 2.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//


import SwiftUI

struct ContentView: View {

    @EnvironmentObject var walletVM: WalletViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel
    


    var body: some View {
        TabView {

            KeuanganView()
                .environmentObject(walletVM)
                .tabItem {
                    Image(systemName: "house")
                    Text("Keuangan")
                }

            LaporanView()
                .environmentObject(walletVM)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Laporan")
                }

            DetailView()
                .environmentObject(walletVM)
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Detail")
                }

            TransferView()
                .environmentObject(walletVM)
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                    Text("Transfer")
                }

            AturView()
                .environmentObject(walletVM)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Atur")
                }
        }
        .environmentObject(walletVM)
        .task {
            await walletVM.loadWallets()
            await categoryVM.loadCategories()

        }

    }
}
