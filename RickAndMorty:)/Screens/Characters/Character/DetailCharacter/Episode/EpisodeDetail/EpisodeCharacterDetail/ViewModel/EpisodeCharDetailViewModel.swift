
import Foundation

protocol EpisodeCharacterDetailProtocol {
    var isFavorite: Box<Bool> { get }
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var gender: String { get }
    var characterImage: String { get }

    init(character: Character)
    func favoriteButtonPressed()
}

final class EpisodeCharacterDetailViewModel: EpisodeCharacterDetailProtocol {

    var isFavorite: Box<Bool>

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
