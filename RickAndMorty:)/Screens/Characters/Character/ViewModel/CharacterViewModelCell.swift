import Foundation

protocol CharacterViewModelCellProtocol {
    var image: Data { get }
    var name: String { get }
    init(character: Character)
}

final class CharacterViewModelCell: CharacterViewModelCellProtocol {
    
    var image: Data {
        let url = URL(string: character.image)
        guard let data = ImageManager.shared.fetchImage(url: url) else {
            return Data()
        }
        return data
    }
    
    var name: String {
        character.name
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
