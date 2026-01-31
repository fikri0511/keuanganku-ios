import SwiftUI

struct ContentView: View{
    var body: some View{
        TabView{
            
            KeuanganView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text ("Keuangan")
                }
            LaporanView()
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text ("Laporan")
                }
            DetailView()
                .tabItem{
                    Image(systemName: "doc.text")
                    Text ("Detail")
                }
            TransferView()
                .tabItem{
                    Image(systemName: "arrow.left.arrow.right")
                    Text ("Transfer")
                }
            AturView()
                .tabItem{
                    Image(systemName: "gearshape")
                    Text ("Atur")
                }
        }
    }
}
