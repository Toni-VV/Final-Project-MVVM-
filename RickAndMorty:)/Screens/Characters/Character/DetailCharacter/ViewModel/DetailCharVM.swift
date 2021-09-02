import Foundation

protocol DetailCharacterViewModelProtocol {
    var isFavorite: Box<Bool> { get }
    var characters: [Character] { get }
    var index: Int { get set }
    var title: String { get }
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var gender: String { get }
    var characterImage: String { get }
    
    init(characters: [Character], index: Int)
    
    func favoriteButtonPressed()
    func episodesViewModel(index: Int) -> EpisodeCharacterViewModelProtocol
}

final class DetailCharacterViewModel: DetailCharacterViewModelProtocol {

   
    var isFavorite: Box<Bool>
    var characters: [Character]
    var index: Int
    
    var title: String {
        character.name
    }
    var name: String {
        character.name
    }
    var status: String {
        character.status
    }
    var species: String {
        character.species
    }
    var gender: String {
        character.gender
    }

    var characterImage: String {
        character.image
    }
    
    private let character: Character

    required init(characters: [Character], index: Int) {
        self.index = index
        self.characters = characters
        self.character = characters[index]
        self.isFavorite = Box(value: DataManager.shared.getFavoriteStatus(for: character.name))
        
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: character.name,
                                             with: isFavorite.value)
    }
    func episodesViewModel(index: Int) -> EpisodeCharacterViewModelProtocol {
        let character = characters[index]
        return EpisodeCharacterViewModel(character: character)
    }
    

}
