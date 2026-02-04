//
//  ContentView 2.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 01/02/26.
//


import SwiftUI

struct ContentView: View {

    @EnvironmentObject var walletVM: WalletViewModel

    var body: some View {
        TabView {

            KeuanganView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Keuangan")
                }

            LaporanView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Laporan")
                }

            DetailView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Detail")
                }

            TransferView()
                .tabItem {
                    Image(systemName: "arrow.left.arrow.right")
                    Text("Transfer")
                }

            AturView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Atur")
                }
        }
    }
}
