import Foundation

protocol DetailCharacterViewModelProtocol {
    var isFavorite: Box<Bool> { get }
    var title: String { get }
    var description: String { get }
    var characterImage: String { get }
    var index: Int { get set }
    var characters: [Character] { get }
    func episodesViewModel(index: Int) -> EpisodeCharacterViewModelProtocol
    
    init(characters: [Character], index: Int)
    func favoriteButtonPressed()
}

final class DetailCharacterViewModel: DetailCharacterViewModelProtocol {

    var characters: [Character]
    var index: Int
    var isFavorite: Box<Bool>
    
    var title: String {
        character.name
    }
    var description: String {
        character.description
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
