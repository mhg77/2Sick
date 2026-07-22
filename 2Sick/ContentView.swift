//
//  ContentView.swift
//  2Sick
//
//  Created by Михаил Асаилов on 20.07.2026.
//

import SwiftUI

enum AppTab: Int, CaseIterable, Identifiable {
    case catalog, favorites, custom, cart

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .catalog:   return "Каталог"
        case .favorites: return "Избранное"
        case .custom:    return "Кастом"
        case .cart:      return "Корзина"
        }
    }

    var icon: String {
        switch self {
        case .catalog:   return "sparkles"
        case .favorites: return "heart.fill"
        case .custom:    return "paintbrush.pointed.fill"
        case .cart:      return "bag.fill"
        }
    }
}

struct ContentView: View {
    @Environment(ShopStore.self) private var store
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var selectedTab: AppTab = .catalog
    @State private var sidebarTab: AppTab? = .catalog

    var body: some View {
        if sizeClass == .regular {
            iPadLayout
        } else {
            iPhoneLayout
        }
    }

    // MARK: - iPhone

    private var iPhoneLayout: some View {
        TabView(selection: $selectedTab) {
            CatalogView()
                .tabItem { Label(AppTab.catalog.title, systemImage: AppTab.catalog.icon) }
                .tag(AppTab.catalog)
            FavoritesView()
                .tabItem { Label(AppTab.favorites.title, systemImage: AppTab.favorites.icon) }
                .tag(AppTab.favorites)
            CustomOrderView()
                .tabItem { Label(AppTab.custom.title, systemImage: AppTab.custom.icon) }
                .tag(AppTab.custom)
            CartView()
                .tabItem { Label(AppTab.cart.title, systemImage: AppTab.cart.icon) }
                .tag(AppTab.cart)
                .badge(store.cartCount)
        }
        .tint(Brand.pink)
    }

    // MARK: - iPad

    private var iPadLayout: some View {
        NavigationSplitView {
            List(selection: $sidebarTab) {
                ForEach(AppTab.allCases) { tab in
                    Label(tab.title, systemImage: tab.icon)
                        .badge(tab == .cart ? store.cartCount : 0)
                        .tag(tab as AppTab?)
                }
            }
            .navigationTitle("SICK²")
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
            .background(Brand.background)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 220)
        } detail: {
            detailView(for: sidebarTab ?? .catalog)
        }
        .tint(Brand.pink)
    }

    @ViewBuilder
    private func detailView(for tab: AppTab) -> some View {
        switch tab {
        case .catalog:   CatalogView()
        case .favorites: FavoritesView()
        case .custom:    CustomOrderView()
        case .cart:      CartView()
        }
    }
}

#Preview {
    ContentView()
        .environment(ShopStore())
        .preferredColorScheme(.dark)
}
