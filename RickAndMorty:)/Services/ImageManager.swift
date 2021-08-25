import Foundation

final class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(url: URL?) -> Data? {
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
