//
//  swiftui_tcaApp.swift
//  swiftui-tca
//
//  Created by yuki naniwa on 2025/03/06.
//

import SwiftUI
import ComposableArchitecture

@main
struct swiftui_tcaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(
                    store: Store(initialState: CounterFeature.State()) {
                        CounterFeature()
                    }
                )
            }
        }
    }
}
