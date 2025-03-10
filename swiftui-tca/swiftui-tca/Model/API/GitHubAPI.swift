import Foundation
import ComposableArchitecture

struct GitHubAPI: @unchecked Sendable {
    var users: (String) async throws -> Users
}

extension GitHubAPI {
    
    static let live = GitHubAPI(
        users: { query in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = "/search/users"
            components.queryItems = [URLQueryItem(name: "q", value: query)]
            
            let jsonDecoder = JSONDecoder()
            let (data, _) = try await URLSession.shared.data(from: components.url!)
            return try jsonDecoder.decode(Users.self, from: data)
        }
    )
}
