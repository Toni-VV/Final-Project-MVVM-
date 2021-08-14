import Foundation

protocol NetworkDataFetcherProtocol {
    func fetchCharacter(urlString: String,
                        completion: @escaping (Result<RickyAndMorty, APIError>) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {

   private var networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = NetworkService()) {
        self.networking = networking
    }
    
    private func request(urlString: String,
                         completion: @escaping (Data?, APIError?) -> Void) {
        guard
            let url = URL(string: urlString)
        else { return }
        let task = networking.request(from: url,
                                      completion: completion)
        task.resume()
    }
    
    private func fetchGenericJsonData<T: Decodable>(urlString: String,
                                         completion: @escaping (Result<T, APIError>) -> Void) {
        self.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error",error.localizedDescription)
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard
                let objects = self.networking.genericJsonDecoder(for: T.self,
                                                                 from: data)
            else {
                completion(.failure(.jsonParsingFailed))
                return
            }
            completion(.success(objects))
        }
    }
    
    func fetchCharacter(urlString: String,
                        completion: @escaping (Result<RickyAndMorty, APIError>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchGenericJsonData(urlString: urlString, completion: completion)
        }
    }
}
