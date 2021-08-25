import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setFavoriteStatus(for character: String, with status: Bool) {
        userDefaults.set(status,forKey: character)
    }
    
    func getFavoriteStatus(for character: String) -> Bool {
        userDefaults.bool(forKey: character)
    }
}
