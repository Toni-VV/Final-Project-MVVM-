import  Foundation

struct ApiClient {
    
    static let baseUrl =  "https://rickandmortyapi.com/api/character"
    
    static func absoluteUrlString(status: String, gender: String) -> String {
        let endPoint = "?status=\(status)&gender=\(gender)"
        return ApiClient.baseUrl + endPoint
    }
}

enum APIError: Error {
    case requestFailed
    case invalidData
    case jsonParsingFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .invalidData:
            return "Invalid Data"
        case .jsonParsingFailed:
            return "Json Parsing Failed"
        }
    }
}
