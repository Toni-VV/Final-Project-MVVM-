import Foundation

protocol NetworkDataFetcherProtocol {
    func fetchCharacter(urlString: String,
                        completion: @escaping (Result<RickyAndMorty, Error>) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {

   private var networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol = NetworkService()) {
        self.networking = networking
    }
    
    private func request(urlString: String,
                         completion: @escaping (Data?, Error?) -> Void) {
        guard
            let url = URL(string: urlString)
        else { return }
        let task = networking.request(from: url,
                                      completion: completion)
        task.resume()
    }
    
    private func fetchGenericJsonData<T: Decodable>(urlString: String,
                                         completion: @escaping (Result<T, Error>) -> Void) {
        self.request(urlString: urlString) { (data, error) in
            if let error = error {
                completion(.failure(error))
                print("Requesting network error", error.localizedDescription)
                return
            }
            guard let data = data else {
                print("Error recieved requesting data")
                return
            }
            guard
                let objects = self.networking.genericJsonDecoder(for: T.self, from: data)
            else { return }
            
            completion(.success(objects))
        }
    }
    
    func fetchCharacter(urlString: String,
                        completion: @escaping (Result<RickyAndMorty, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchGenericJsonData(urlString: urlString,
                                      completion: completion)
        }
    }
}
