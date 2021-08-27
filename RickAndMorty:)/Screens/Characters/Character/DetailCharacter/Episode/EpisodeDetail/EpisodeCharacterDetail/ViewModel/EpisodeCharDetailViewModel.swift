
import Foundation

protocol EpisodeCharacterDetailProtocol {
    var isFavorite: Box<Bool> { get }
    var title: String { get }
    var description: String { get }
    var characterImageData: Data { get }
   
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
    var characterImageData: Data {
        let url = URL(string: character.image)
        guard
            let data = ImageManager.shared.fetchImage(url: url)
        else { return Data() }
        return data
    }
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
        self.isFavorite = Box(value: DataManager.shared.getFavoriteStatus(for: character.url))
    }
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: character.url,
                                             with: isFavorite.value)
    }
}
