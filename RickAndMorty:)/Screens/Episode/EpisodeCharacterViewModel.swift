import Foundation

protocol EpisodeCharacterViewModelProtocol {
    var episodes: [Episode] { get set }
    var numberOfRows: Int { get }
    
    func fetchData(urlString: String, completion: @escaping (Episode) -> Void)
    func episodeUrl(index: Int) -> String
    func episodeDetailViewModel(index: Int) -> EpisodeDetailViewModelProtocol
}

final class EpisodeCharacterViewModel: EpisodeCharacterViewModelProtocol {

    var episodes: [Episode] = []
    
    var numberOfRows: Int {
        character.episode.count
    }
    
    private var networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()
    private let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func fetchData(urlString: String, completion: @escaping (Episode) -> Void) {
        networkDataFetcher.fetchEpisode(urlString: urlString) { (result) in
            switch result {
            case .success(let episode):
                completion(episode)
            case .failure(let error):
                print("Network fetch episodes error", error.localizedDescription)
            }
        }
    }
    
    func episodeUrl(index: Int) -> String {
        let urlString = character.episode[index]
        return urlString
    }
    
    func episodeDetailViewModel(index: Int) -> EpisodeDetailViewModelProtocol {
        let episode = episodes[index]
        return EpisodeDetailViewModel(episode: episode)
    }
    
    
}
