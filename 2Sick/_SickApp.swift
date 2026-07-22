//
//  _SickApp.swift
//  2Sick
//
//  Created by Михаил Асаилов on 20.07.2026.
//

import SwiftUI

@main
struct _SickApp: App {
    @State private var store = ShopStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(store)
                .preferredColorScheme(.dark)
        }
    }
}
