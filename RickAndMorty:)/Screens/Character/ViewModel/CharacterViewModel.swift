import Foundation

protocol CharacterViewModelProtocol {
    var characters: [Character] { get set }
    var numberOfRows: Int { get }
    var filteredNumberOfRows: Int { get }
    var rickAndMorty: RickyAndMorty? { get }
    var filterCharachter: [Character] { get set }
    
    func fetchData(urlString: String, completion: @escaping () -> Void)
    func viewModelCell(index: IndexPath) -> CharacterViewModelCellProtocol
    func filterViewModelCell(index: IndexPath) -> CharacterViewModelCellProtocol
    func detailViewModel(index: IndexPath) -> DetailCharacterViewModelProtocol
    func filteredDetailViewModel(index: IndexPath) -> DetailCharacterViewModelProtocol
}

final class CharacterViewModel: CharacterViewModelProtocol {

    var networkDataFetcher: NetworkDataFetcherProtocol
    var characters: [Character] = []
    var filterCharachter: [Character] = []
    var rickAndMorty: RickyAndMorty?

    var numberOfRows: Int {
        characters.count
    }
    var filteredNumberOfRows: Int {
        filterCharachter.count
    }
    
    init(networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchData(urlString: String, completion: @escaping () -> Void) {
        networkDataFetcher.fetchCharacter(urlString: urlString) { (result) in
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                let result = rickAndMorty.results
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: result)
                        completion()
                }
            case .failure(let error):
                print("Network fetch error", error.localizedDescription)
            }
        }
    }

    func viewModelCell(index: IndexPath) -> CharacterViewModelCellProtocol {
        let characterCell = characters[index.row]
        return CharacterViewModelCell(character: characterCell)
    }
    
    func filterViewModelCell(index: IndexPath) -> CharacterViewModelCellProtocol {
        let filterCell = filterCharachter[index.row]
        return CharacterViewModelCell(character: filterCell) 
    }
    
    func detailViewModel(index: IndexPath) -> DetailCharacterViewModelProtocol {
        let detailCharacter = characters[index.row]
        return DetailCharacterViewModel(character: detailCharacter)
    }
    func filteredDetailViewModel(index: IndexPath) -> DetailCharacterViewModelProtocol {
        let detailCharacter = filterCharachter[index.row]
        return DetailCharacterViewModel(character: detailCharacter)
    }
}
