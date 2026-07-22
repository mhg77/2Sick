//
//  CatalogView.swift
//  2Sick
//

import SwiftUI

struct CatalogView: View {
    @Environment(ShopStore.self) private var store
    @State private var selectedCollection: ProductCollection = .all
    @State private var selectedCategory: ProductCategory?
    @State private var searchText = ""

    private var filteredProducts: [Product] {
        store.products.filter { product in
            let matchesCollection = selectedCollection == .all
                || product.collection == selectedCollection
                || product.collection == .all
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            let matchesSearch = searchText.isEmpty
                || product.name.localizedCaseInsensitiveContains(searchText)
            return matchesCollection && matchesCategory && matchesSearch
        }
    }

    private let columns = [GridItem(.adaptive(minimum: 160, maximum: 220), spacing: 12)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    logoBanner
                    collectionPicker
                        .sensoryFeedback(.selection, trigger: selectedCollection)
                    categoryChips
                        .sensoryFeedback(.selection, trigger: selectedCategory)
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(filteredProducts) { product in
                            NavigationLink(value: product) {
                                ProductCard(product: product)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    if filteredProducts.isEmpty {
                        ContentUnavailableView("Ничего не найдено",
                                               systemImage: "sparkle.magnifyingglass",
                                               description: Text("Попробуйте изменить фильтры или запрос"))
                            .padding(.top, 40)
                    }
                }
                .padding(.horizontal)
            }
            .background(Brand.background)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
            .searchable(text: $searchText, prompt: "Поиск украшений")
        }
    }

    private var logoBanner: some View {
        Image("AppLogo")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var collectionPicker: some View {
        Picker("Коллекция", selection: $selectedCollection) {
            ForEach(ProductCollection.allCases) { collection in
                Text(collection.rawValue).tag(collection)
            }
        }
        .pickerStyle(.segmented)
    }

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ProductCategory.allCases) { category in
                    let isSelected = selectedCategory == category
                    Button {
                        withAnimation(.snappy) {
                            selectedCategory = isSelected ? nil : category
                        }
                    } label: {
                        Label(category.rawValue, systemImage: category.icon)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(isSelected ? Brand.pink : Brand.card, in: Capsule())
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}

struct ProductCard: View {
    @Environment(ShopStore.self) private var store
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProductImageTile(product: product)
                .frame(height: 140)
                .overlay(alignment: .topTrailing) {
                    Button {
                        store.toggleFavorite(product)
                    } label: {
                        Image(systemName: store.isFavorite(product) ? "heart.fill" : "heart")
                            .foregroundStyle(Brand.pink)
                            .padding(8)
                            .background(.black.opacity(0.4), in: Circle())
                    }
                    .padding(6)
                }
                .sensoryFeedback(.selection, trigger: store.isFavorite(product))
            Text(product.name)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white)
                .lineLimit(1)
            Text(product.formattedPrice)
                .font(.headline)
                .foregroundStyle(Brand.pink)
        }
    }
}

#Preview {
    CatalogView()
        .environment(ShopStore())
        .preferredColorScheme(.dark)
}
