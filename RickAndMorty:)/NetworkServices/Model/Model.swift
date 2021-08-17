import Foundation

struct RickyAndMorty: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var description: String {
            """
        Name:   \(name)
        Status:   \(status)
        Species:   \(species)
        Gender:   \(gender)
        """
        }
}

struct Location: Decodable {
    let name: String
}
//Origin:   \(origin.name)
//Location:   \(location.name)
