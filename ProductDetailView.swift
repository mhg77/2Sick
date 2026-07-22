//
//  ProductDetailView.swift
//  2Sick
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(ShopStore.self) private var store
    @Environment(\.horizontalSizeClass) private var sizeClass
    let product: Product
    @State private var addedToCart = false

    var body: some View {
        ScrollView {
            if sizeClass == .regular {
                HStack(alignment: .top, spacing: 32) {
                    ProductImageTile(product: product)
                        .frame(width: 360, height: 360)
                    infoColumn
                }
                .padding()
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    ProductImageTile(product: product)
                        .frame(height: 300)
                    infoColumn
                }
                .padding()
            }
        }
        .background(Brand.background)
        .navigationBarTitleDisplayMode(.inline)
        .sensoryFeedback(.impact(weight: .medium), trigger: addedToCart) { _, new in new }
        .sensoryFeedback(.selection, trigger: store.isFavorite(product))
    }

    private var infoColumn: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Text("\(product.category.rawValue) · \(product.collection.rawValue)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    store.toggleFavorite(product)
                } label: {
                    Image(systemName: store.isFavorite(product) ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundStyle(Brand.pink)
                }
            }

            Text(product.formattedPrice)
                .font(.title.bold())
                .foregroundStyle(Brand.pink)

            Text(product.details)
                .font(.body)
                .foregroundStyle(.secondary)

            Spacer(minLength: 20)

            Button {
                store.add(product)
                addedToCart = true
                Task {
                    try? await Task.sleep(for: .seconds(1.5))
                    addedToCart = false
                }
            } label: {
                Label(addedToCart ? "Добавлено!" : "В корзину",
                      systemImage: addedToCart ? "checkmark" : "bag.badge.plus")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(addedToCart ? Color.green : Brand.pink, in: RoundedRectangle(cornerRadius: 14))
                    .foregroundStyle(.white)
            }
            .animation(.snappy, value: addedToCart)
        }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(product: ShopStore().products[0])
    }
    .environment(ShopStore())
    .preferredColorScheme(.dark)
}
