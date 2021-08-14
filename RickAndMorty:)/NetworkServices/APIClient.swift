import  Foundation

struct ApiClient {
    
    static let baseUrl =  "https://rickandmortyapi.com/api/character"
    
    static func absoluteString(status: String, gender: String) -> String {
        let endPoint = "?status=\(status)&gender=\(gender)"
        return ApiClient.baseUrl + endPoint
    }
}

