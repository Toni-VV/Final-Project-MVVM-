import Foundation

protocol EpisodeDetailViewModelProtocol {
    var description: String { get }
    var numberOfRows: Int { get }
    var characterUrlStrings: [String]  { get }
    var characters: [Character] { get set }
    init(episode: Episode)
    func fetchData(urlString: String, completion: @escaping (Character) -> Void)
    func detailEpisodeCharacter(index: IndexPath) -> EpisodeCharacterDetailProtocol
    func setCharacters()
}


final class EpisodeDetailViewModel: EpisodeDetailViewModelProtocol {

    var description: String {
        episode.description
    }
    
    var numberOfRows: Int {
        episode.characters.count
    }
    
    var characterUrlStrings: [String] {
        episode.characters
    }
    
    var characters: [Character] = [] {
        didSet {
            if characters.count == episode.characters.count {
                characters = characters.sorted { $0.id < $1.id }
            }
        }
    }
    
    private let episode: Episode
    private var networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    func fetchData(urlString: String, completion: @escaping (Character) -> Void) {
        networkDataFetcher.fetchCharacter(urlString: urlString) { (result) in
            switch result {
            case .success(let character):
                completion(character)
            case .failure(let error):
                print("",error.localizedDescription)
            }
        }
    }
    
    func setCharacters() {
        characterUrlStrings.forEach {
            networkDataFetcher.fetchCharacter(urlString: $0) { (result) in
                switch result {
                case .success(let character):
                    self.characters.append(character)
                case .failure(let error):
                    print("", error.localizedDescription)
                }
            }
        }
    }
    
    func detailEpisodeCharacter(index: IndexPath) -> EpisodeCharacterDetailProtocol {
        let character = characters[index.row]
        return EpisodeCharacterDetailViewModel(character: character)
    }
    
    
}
