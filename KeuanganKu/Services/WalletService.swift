import Supabase
import Foundation
final class WalletService {
    static let shared = WalletService()
    
    func fetchWallets() async throws -> [Wallet] {
        let client = SupabaseConfig.shared.client
        let userId = try await AuthService.shared.currentUserId()
        
        let response = try await client
            .from("wallets")
            .select()
            .eq("user_id", value: userId)
            .order("created_at", ascending: true)
            .execute()
        
        return try JSONDecoder().decode([Wallet].self, from: response.data)
    }
    func createWallet(name: String, balance: Double, icon: String) async throws {

        let client = SupabaseConfig.shared.client
        let userId = try await AuthService.shared.currentUserId()

        let request = CreateWalletRequest(
            name: name,
            balance: balance,
            icon: icon,
            user_id: userId.uuidString
        )

        try await client
            .from("wallets")
            .insert(request)
            .execute()
    }

}
struct CreateWalletRequest: Encodable {
    let name: String
    let balance: Double
    let icon: String
    let user_id: String
}
