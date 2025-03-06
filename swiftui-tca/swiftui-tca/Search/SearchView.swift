import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    let store: Store<SearchState, SearchAction>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    TextField("user name",
                              text: viewStore.binding(
                                get: \.searchQuery, send: SearchAction.searchQueryEditing
                              )
                    )
                    .onChange(of: viewStore.searchQuery) { _ in
                        viewStore.send(.searchQueryEditing(viewStore.searchQuery))
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                    Spacer()
                    List(viewStore.users) { user in
                        NavigationLink(destination: Text(":TODO")) {
                            UserCell(user: user)
                        }
                    }
                    .refreshable {
                        viewStore.send(.searchQueryEditing(viewStore.searchQuery))
                    }
                }
                .navigationTitle("🔍Search Github User")
            }
        }
    }
}

