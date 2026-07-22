//
//  ContentView.swift
//  2Sick
//
//  Created by Михаил Асаилов on 20.07.2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(ShopStore.self) private var store

    var body: some View {
        TabView {
            Tab("Каталог", systemImage: "sparkles") {
                CatalogView()
            }
            Tab("Избранное", systemImage: "heart.fill") {
                FavoritesView()
            }
            Tab("Кастом", systemImage: "paintbrush.pointed.fill") {
                CustomOrderView()
            }
            Tab("Корзина", systemImage: "bag.fill") {
                CartView()
            }
            .badge(store.cartCount)
        }
        .tint(Brand.pink)
    }
}

#Preview {
    ContentView()
        .environment(ShopStore())
        .preferredColorScheme(.dark)
}
