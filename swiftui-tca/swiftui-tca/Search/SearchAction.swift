import ComposableArchitecture

enum SearchAction: Equatable {
    case searchQueryEditing(String)
    case response(Result<[User], APIError>)
}
