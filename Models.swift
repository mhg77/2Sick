//
//  Models.swift
//  2Sick
//

import SwiftUI

enum ProductCategory: String, CaseIterable, Identifiable {
    case earrings = "Серьги"
    case necklaces = "Колье"
    case chokers = "Чокеры"
    case rings = "Кольца"
    case bracelets = "Браслеты"
    case anklets = "Анклеты"
    case bags = "Сумки"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .earrings: return "sparkles"
        case .necklaces: return "link"
        case .chokers: return "circle.dashed"
        case .rings: return "circle.circle"
        case .bracelets: return "figure.wave"
        case .anklets: return "shoeprints.fill"
        case .bags: return "bag.fill"
        }
    }
}

enum ProductCollection: String, CaseIterable, Identifiable {
    case all = "Все"
    case forHer = "Для девушек"
    case forHim = "Для парней"

    var id: String { rawValue }
}

struct Product: Identifiable, Hashable {
    let id: UUID
    let name: String
    let category: ProductCategory
    let collection: ProductCollection
    let price: Int
    let details: String
    let isNew: Bool

    init(name: String,
         category: ProductCategory,
         collection: ProductCollection,
         price: Int,
         details: String,
         isNew: Bool = false) {
        self.id = UUID()
        self.name = name
        self.category = category
        self.collection = collection
        self.price = price
        self.details = details
        self.isNew = isNew
    }

    var formattedPrice: String {
        "\(price.formatted(.number.grouping(.automatic))) ₽"
    }
}

struct CartItem: Identifiable {
    let id: UUID
    let product: Product
    var quantity: Int

    init(product: Product, quantity: Int = 1) {
        self.id = product.id
        self.product = product
        self.quantity = quantity
    }

    var total: Int { product.price * quantity }
}
