import Foundation

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
}
