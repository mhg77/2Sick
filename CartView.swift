//
//  CartView.swift
//  2Sick
//

import SwiftUI

struct CartView: View {
    @Environment(ShopStore.self) private var store
    @State private var showOrderPlaced = false

    var body: some View {
        NavigationStack {
            Group {
                if store.cartItems.isEmpty {
                    ContentUnavailableView("Корзина пуста",
                                           systemImage: "bag",
                                           description: Text("Добавьте украшения из каталога"))
                } else {
                    List {
                        ForEach(store.cartItems) { item in
                            CartRow(item: item)
                                .listRowBackground(Brand.card)
                        }
                        .onDelete { offsets in
                            for offset in offsets {
                                store.remove(store.cartItems[offset].product)
                            }
                        }

                        Section {
                            HStack {
                                Text("Итого")
                                    .font(.headline)
                                Spacer()
                                Text("\(store.cartTotal.formatted()) ₽")
                                    .font(.title3.bold())
                                    .foregroundStyle(Brand.pink)
                            }
                            .listRowBackground(Brand.card)

                            Button {
                                showOrderPlaced = true
                                store.clearCart()
                            } label: {
                                Text("Оформить заказ")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 6)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Brand.pink)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .background(Brand.background)
            .navigationTitle("Корзина")
            .alert("Заказ оформлен!", isPresented: $showOrderPlaced) {
                Button("Ок") {}
            } message: {
                Text("Спасибо за покупку в SICK²! Мы свяжемся с вами для подтверждения.")
            }
        }
    }
}

private struct CartRow: View {
    @Environment(ShopStore.self) private var store
    let item: CartItem

    var body: some View {
        HStack(spacing: 12) {
            ProductImageTile(product: item.product)
                .frame(width: 56, height: 56)
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(.subheadline.weight(.medium))
                Text(item.product.formattedPrice)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            HStack(spacing: 10) {
                Button {
                    store.setQuantity(item.quantity - 1, for: item.product)
                } label: {
                    Image(systemName: "minus.circle.fill")
                }
                Text("\(item.quantity)")
                    .font(.headline)
                    .monospacedDigit()
                Button {
                    store.setQuantity(item.quantity + 1, for: item.product)
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .buttonStyle(.plain)
            .foregroundStyle(Brand.pink)
        }
    }
}

#Preview {
    let store = ShopStore()
    store.add(store.products[0])
    store.add(store.products[3])
    return CartView()
        .environment(store)
        .preferredColorScheme(.dark)
}
