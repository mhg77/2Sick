//
//  Theme.swift
//  2Sick
//

import SwiftUI

// Фирменная розово-чёрная палитра SICK²
enum Brand {
    static let pink = Color(red: 1.0, green: 0.30, blue: 0.58)
    static let pinkSoft = Color(red: 1.0, green: 0.62, blue: 0.78)
    static let background = Color(red: 0.06, green: 0.05, blue: 0.07)
    static let card = Color(red: 0.13, green: 0.11, blue: 0.14)
}

// Плитка-заглушка вместо фото товара: градиент и иконка категории
struct ProductImageTile: View {
    let product: Product

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [Brand.card, Brand.pink.opacity(0.35)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: product.category.icon)
                    .font(.system(size: 36))
                    .foregroundStyle(Brand.pinkSoft)
            }
            .overlay(alignment: .topLeading) {
                if product.isNew {
                    Text("NEW")
                        .font(.caption2.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Brand.pink, in: Capsule())
                        .foregroundStyle(.white)
                        .padding(8)
                }
            }
    }
}
