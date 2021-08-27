
import Foundation

protocol EpisodeCharacterDetailProtocol {
    var isFavorite: Box<Bool> { get }
    var title: String { get }
    var description: String { get }
    var characterImage: String { get }
   
    init(character: Character)
    func favoriteButtonPressed()
}

final class EpisodeCharacterDetailViewModel: EpisodeCharacterDetailProtocol {
    
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
    
    init(character: Character) {
        self.character = character
        self.isFavorite = Box(value: DataManager.shared.getFavoriteStatus(for: character.name))
    }
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: character.name,
                                             with: isFavorite.value)
    }
}
