//
//  ShopStoreTests.swift
//  2SickTests
//

import Testing
@testable import _Sick

@MainActor
struct ShopStoreTests {

    // MARK: - Каталог

    @Test func productCatalogIsNotEmpty() {
        let store = ShopStore()
        #expect(!store.products.isEmpty)
    }

    @Test func allProductsHavePositivePrice() {
        let store = ShopStore()
        #expect(store.products.allSatisfy { $0.price > 0 })
    }

    @Test func productFormattedPriceContainsRubleSign() {
        let store = ShopStore()
        #expect(store.products.allSatisfy { $0.formattedPrice.contains("₽") })
    }

    // MARK: - Корзина: добавление

    @Test func addProductIncreasesCartCount() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        #expect(store.cartCount == 1)
    }

    @Test func addSameProductIncreasesQuantityNotItemCount() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.add(product)
        #expect(store.cartItems.count == 1)
        #expect(store.cartCount == 2)
    }

    @Test func addedProductAppearsInCartItems() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        #expect(store.cartItems.first?.product.id == product.id)
    }

    // MARK: - Корзина: удаление

    @Test func removeProductClearsItFromCart() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.remove(product)
        #expect(store.cartItems.isEmpty)
        #expect(store.cartCount == 0)
    }

    @Test func setQuantityToZeroRemovesItem() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.setQuantity(0, for: product)
        #expect(store.cartItems.isEmpty)
    }

    @Test func setQuantityToNegativeRemovesItem() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.setQuantity(-1, for: product)
        #expect(store.cartItems.isEmpty)
    }

    @Test func setQuantityUpdatesValue() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.setQuantity(5, for: product)
        #expect(store.quantity(of: product) == 5)
    }

    @Test func clearCartRemovesAllItems() {
        let store = ShopStore()
        store.add(store.products[0])
        store.add(store.products[1])
        store.clearCart()
        #expect(store.cartItems.isEmpty)
        #expect(store.cartCount == 0)
    }

    // MARK: - Корзина: подсчёт суммы

    @Test func cartTotalMatchesSumOfItems() {
        let store = ShopStore()
        let p1 = store.products[0]
        let p2 = store.products[1]
        store.add(p1)
        store.add(p2)
        #expect(store.cartTotal == p1.price + p2.price)
    }

    @Test func cartItemTotalEqualsQuantityTimesPrice() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.add(product)
        store.add(product)
        let item = store.cartItems.first!
        #expect(item.total == product.price * 3)
    }

    @Test func quantityHelperReturnsZeroForAbsentProduct() {
        let store = ShopStore()
        #expect(store.quantity(of: store.products[0]) == 0)
    }

    @Test func emptyCartHasZeroTotal() {
        let store = ShopStore()
        #expect(store.cartTotal == 0)
    }

    // MARK: - Избранное

    @Test func newStoreHasNoFavorites() {
        let store = ShopStore()
        #expect(store.favorites.isEmpty)
    }

    @Test func toggleFavoriteAddsProduct() {
        let store = ShopStore()
        let product = store.products[0]
        store.toggleFavorite(product)
        #expect(store.isFavorite(product))
    }

    @Test func toggleFavoriteTwiceRemovesProduct() {
        let store = ShopStore()
        let product = store.products[0]
        store.toggleFavorite(product)
        store.toggleFavorite(product)
        #expect(!store.isFavorite(product))
    }

    @Test func favoritesListReflectsToggledProducts() {
        let store = ShopStore()
        let p1 = store.products[0]
        let p2 = store.products[3]
        store.toggleFavorite(p1)
        store.toggleFavorite(p2)
        #expect(store.favorites.count == 2)
        #expect(store.favorites.contains { $0.id == p1.id })
        #expect(store.favorites.contains { $0.id == p2.id })
    }

    @Test func cartAndFavoritesAreIndependent() {
        let store = ShopStore()
        let product = store.products[0]
        store.add(product)
        store.toggleFavorite(product)
        store.clearCart()
        #expect(store.isFavorite(product))
        #expect(store.cartItems.isEmpty)
    }
}
