import ComposableArchitecture

struct SearchReducer: Reducer {
    func reduce(into state: inout SearchState, action: SearchAction) -> Effect<SearchAction> {
        switch action {
        case let .searchQueryEditing(query):
//            struct SearchUserId: Hashable {}
//
//            let environment = AppEnvironment()
//            return environment.githubApi
//                .users(query)
//            return .send(.)
            return .none
        case let .response(.success(users)):
//            state.users = users
            return .none
        case let .response(.failure(error)):
            print(error)
            return .none
        }
    }
}
