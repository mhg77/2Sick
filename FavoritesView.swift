//
//  FavoritesView.swift
//  2Sick
//

import SwiftUI

struct FavoritesView: View {
    @Environment(ShopStore.self) private var store

    private let columns = [GridItem(.adaptive(minimum: 160, maximum: 220), spacing: 12)]

    var body: some View {
        NavigationStack {
            Group {
                if store.favorites.isEmpty {
                    ContentUnavailableView("Пока пусто",
                                           systemImage: "heart",
                                           description: Text("Нажмите ♥ на товаре, чтобы сохранить его сюда"))
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(store.favorites) { product in
                                NavigationLink(value: product) {
                                    ProductCard(product: product)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Brand.background)
            .navigationTitle("Избранное")
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
        }
    }
}

#Preview {
    let store = ShopStore()
    store.toggleFavorite(store.products[0])
    store.toggleFavorite(store.products[5])
    return FavoritesView()
        .environment(store)
        .preferredColorScheme(.dark)
}
