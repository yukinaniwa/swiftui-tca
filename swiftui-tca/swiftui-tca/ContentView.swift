//
//  ContentView.swift
//  swiftui-tca
//
//  Created by yuki naniwa on 2025/03/06.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
    }

    enum Action {
        // ユーザーが実際に行う操作に基づいて命名
        case decrementButtonTapped
        case incrementButtonTapped
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none

            case .incrementButtonTapped:
                state.count += 1
                return .none
            }
        }
    }
}


struct ContentView: View {

    let store: StoreOf<CounterFeature>

    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)

                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
