import Foundation

protocol NetworkingProtocol {
    func request(from url: URL,
                 completion: @escaping (Data?, APIError?) -> Void) -> URLSessionDataTask
    func genericJsonDecoder<T: Decodable>(for type: T.Type,
                                          from data: Data?) -> T?
}

struct NetworkService: NetworkingProtocol {
    
    func request(from url: URL,
                 completion: @escaping (Data?, APIError?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data,error as? APIError)
            }
        }
    }
    
    func genericJsonDecoder<T: Decodable>(for type: T.Type,
                                          from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        
        do {
            let response = try decoder.decode(type.self, from: data)
            return response
        } catch let error {
            print("Failed do decode json", error)
            return nil
        }
    }
}
