//
//  ShopStore.swift
//  2Sick
//

import SwiftUI

@Observable
final class ShopStore {
    let products: [Product]
    private(set) var cartItems: [CartItem] = []
    private(set) var favoriteIDs: Set<UUID> = []

    init() {
        products = Self.sampleProducts
    }

    // MARK: - Корзина

    func add(_ product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product))
        }
    }

    func remove(_ product: Product) {
        cartItems.removeAll { $0.product.id == product.id }
    }

    func setQuantity(_ quantity: Int, for product: Product) {
        guard let index = cartItems.firstIndex(where: { $0.product.id == product.id }) else { return }
        if quantity <= 0 {
            cartItems.remove(at: index)
        } else {
            cartItems[index].quantity = quantity
        }
    }

    func quantity(of product: Product) -> Int {
        cartItems.first(where: { $0.product.id == product.id })?.quantity ?? 0
    }

    func clearCart() {
        cartItems.removeAll()
    }

    var cartCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }

    var cartTotal: Int {
        cartItems.reduce(0) { $0 + $1.total }
    }

    // MARK: - Избранное

    func toggleFavorite(_ product: Product) {
        if favoriteIDs.contains(product.id) {
            favoriteIDs.remove(product.id)
        } else {
            favoriteIDs.insert(product.id)
        }
    }

    func isFavorite(_ product: Product) -> Bool {
        favoriteIDs.contains(product.id)
    }

    var favorites: [Product] {
        products.filter { favoriteIDs.contains($0.id) }
    }

    // MARK: - Демо-каталог

    private static let sampleProducts: [Product] = [
        Product(name: "Серьги Broken Heart", category: .earrings, collection: .forHer,
                price: 1490, details: "Асимметричная пара с половинками сердца. Гипоаллергенная сталь с розовым PVD-покрытием.", isNew: true),
        Product(name: "Серьги-кресты Gothic", category: .earrings, collection: .forHim,
                price: 1290, details: "Массивные кресты на цепочке. Чернёная нержавеющая сталь."),
        Product(name: "Серьги Pink Flame", category: .earrings, collection: .forHer,
                price: 1690, details: "Языки пламени с розовой эмалью. Английский замок."),
        Product(name: "Колье Barbed Wire", category: .necklaces, collection: .forHim,
                price: 2190, details: "Колье в виде колючей проволоки. Регулируемая длина 40–45 см.", isNew: true),
        Product(name: "Колье Cherry Bomb", category: .necklaces, collection: .forHer,
                price: 1990, details: "Подвеска-вишня с эмалью на тонкой цепочке."),
        Product(name: "Чокер Spike", category: .chokers, collection: .all,
                price: 1790, details: "Кожаный чокер с шипами. Унисекс, регулируемый размер."),
        Product(name: "Чокер Velvet Pink", category: .chokers, collection: .forHer,
                price: 1390, details: "Бархатный чокер с подвеской-сердцем.", isNew: true),
        Product(name: "Кольцо Skull", category: .rings, collection: .forHim,
                price: 1590, details: "Массивное кольцо с черепом. Размеры 17–22."),
        Product(name: "Кольцо Chain Ring", category: .rings, collection: .all,
                price: 1190, details: "Кольцо-цепь из полированной стали. Унисекс."),
        Product(name: "Кольцо Heartbreaker", category: .rings, collection: .forHer,
                price: 1290, details: "Кольцо с разбитым сердцем и розовым цирконом."),
        Product(name: "Браслет Chunky Chain", category: .bracelets, collection: .forHim,
                price: 1890, details: "Крупная панцирная цепь. Карабиновый замок."),
        Product(name: "Браслет Candy", category: .bracelets, collection: .forHer,
                price: 990, details: "Браслет из розовых и чёрных бусин с шармом-сердцем."),
        Product(name: "Анклет Moonlight", category: .anklets, collection: .forHer,
                price: 890, details: "Анклет с подвесками-лунами. Длина 22–25 см.", isNew: true),
        Product(name: "Анклет Razor", category: .anklets, collection: .all,
                price: 990, details: "Анклет с подвеской-лезвием. Унисекс."),
        Product(name: "Сумка Mini Coffin", category: .bags, collection: .forHer,
                price: 3490, details: "Мини-сумка в форме гроба. Экокожа, съёмный ремень."),
        Product(name: "Шоппер SICK²", category: .bags, collection: .all,
                price: 1490, details: "Чёрный шоппер с розовым логотипом SICK². Плотный хлопок."),
    ]
}
