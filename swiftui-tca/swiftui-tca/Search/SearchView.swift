//
//  SearchView.swift
//  swiftui-tca
//
//  Created by yuki naniwa on 2025/03/06.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SearchUserFeature {
    @ObservableState
    struct State : Equatable {
        var query = ""
        var users = [User]()
    }

    enum Action {
        // ユーザーが実際に行う操作に基づいて命名
        case api(query: String)
        case apiResponse(users: [User])
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .api(query):
                print("search: q = \(query)")
                return .run { send in
                    let users = try await GitHubAPI.live.users(query).items
                    await send(.apiResponse(users: users))
                }
            case let .apiResponse(users):
                state.users = users
                return .none
            }
        }
    }
}


struct SearchView: View {

    let store: StoreOf<SearchUserFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 12) {
                TextField("user name",
                          text: viewStore.binding(
                            get: \.query, send: SearchUserFeature.Action.api
                          )
                )
                .onChange(of: viewStore.query) { _ in
                    viewStore.send(.api(query: viewStore.query))
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                .padding()
                                    
                List(viewStore.users) { user in
                    NavigationLink(destination: Text("\(user)")) {
                        UserCell(user: user)
                    }
                }
                .refreshable {
                    viewStore.send(.api(query: viewStore.query))
                }
                .scrollDismissesKeyboard(.immediately)
            }
            .navigationTitle("Search Github User")
        }
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchUserFeature.State()) {
            SearchUserFeature()
        }
    )
}
