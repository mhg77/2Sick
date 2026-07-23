# 2Sick — Jewelry & Accessories

iOS/iPadOS app for the **2Sick** jewelry store, built with SwiftUI.

## Features

- **Catalog** — browse collections and categories (earrings, necklaces, chokers, rings, bracelets, anklets, bags), search and filter
- **Product detail** — description, price, add to cart
- **Favorites** — save items you like
- **Cart** — manage order, calculate total
- **Custom order** — form to request a piece with individual parameters

## Platforms

| Platform | Minimum version |
|---|---|
| iPhone | iOS 17.0+ |
| iPad | iOS 17.0+ |

iPad uses `NavigationSplitView` with a sidebar; iPhone uses a standard `TabView`.

## Stack

| Technology | Description |
|---|---|
| Swift 6 | Strict concurrency |
| SwiftUI | Declarative UI |
| `@Observable` | SwiftUI-native state, no Combine |
| `NavigationSplitView` | Adaptive navigation for iPad |
| `sensoryFeedback` | Haptics on iPhone and iPad |

## Tests

20 unit tests using Swift Testing (`2SickTests`), covering business logic:

| Group | What is tested |
|---|---|
| Catalog | Not empty, all prices > 0, ₽ formatting |
| Cart — adding | Count, uniqueness, product identity |
| Cart — removal | `remove`, `setQuantity(0)`, negative quantity |
| Cart — totals | Total sum, `CartItem.total`, empty cart = 0 |
| Favorites | Toggle add/remove, list, independence from cart |

Run: **⌘U** in Xcode or `xcodebuild test -scheme 2Sick`.

## Project structure

```
2Sick/
├── 2Sick/
│   ├── _SickApp.swift         — entry point (@main)
│   └── ContentView.swift      — root screen (TabView / NavigationSplitView)
├── 2SickTests/
│   └── ShopStoreTests.swift   — unit tests (Swift Testing, 20 tests)
├── Models.swift               — data models (Product, CartItem, Enums)
├── ShopStore.swift            — state store (@Observable)
├── Theme.swift                — brand colors and ProductImageTile
├── CatalogView.swift          — catalog with adaptive grid
├── ProductDetailView.swift    — product card (side-by-side on iPad)
├── FavoritesView.swift        — favorite items
├── CartView.swift             — cart and checkout
└── CustomOrderView.swift      — custom order form
```
