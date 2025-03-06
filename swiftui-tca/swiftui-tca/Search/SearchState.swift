import Foundation
import ComposableArchitecture

struct SearchState: Equatable {
    var users = [User]()
    var searchQuery: String = ""
}
