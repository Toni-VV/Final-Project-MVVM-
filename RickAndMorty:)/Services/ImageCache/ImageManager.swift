import UIKit

final class ImageManager {

    static let shared = ImageManager()

    private init() {}

    func fetchImage(url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            completion(data,response)
        }.resume()
    }
}
