import Foundation

protocol EpisodeDetailCellProtocol {
    var image: String { get }
    var name: String { get }
    init(character: Character)
}

final class EpisodeDetailCellViewModel: EpisodeDetailCellProtocol {
    
    var image: String {
        character.image
    }
    
    var name: String {
        character.name
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
