import Foundation

protocol CharacterViewModelCellProtocol {
    var image: Data { get }
    var name: String { get }
    init(character: Character)
}

class CharacterViewModelCell: CharacterViewModelCellProtocol {
    
    let character: Character
    
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
    
    required init(character: Character) {
        self.character = character
    }
}
