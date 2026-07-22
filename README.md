# 2Sick — украшения и аксессуары

Мобильное приложение для iPhone и iPad магазина украшений **2Sick**, написанное на SwiftUI.

## Возможности

- **Каталог** — просмотр коллекций и категорий (серьги, колье, чокеры, кольца, браслеты, анклеты, сумки), поиск и фильтрация
- **Детали товара** — описание, цена, добавление в корзину
- **Избранное** — сохранение понравившихся изделий
- **Корзина** — управление заказом, подсчёт суммы
- **Кастомный заказ** — форма для создания украшения по индивидуальным параметрам

## Поддерживаемые платформы

| Платформа | Минимальная версия |
|---|---|
| iPhone | iOS 17.0+ |
| iPad | iOS 17.0+ |

На iPad используется `NavigationSplitView` с боковым меню (sidebar), на iPhone — стандартный `TabView`.

## Стек

| Технология | Описание |
|---|---|
| Swift 6 | Строгая конкурентность |
| SwiftUI | Декларативный UI |
| `@Observable` | SwiftUI-native state без Combine |
| `NavigationSplitView` | Адаптивная навигация для iPad |

## Структура проекта

```
2Sick/
├── 2Sick/
│   ├── _SickApp.swift         — точка входа (@main)
│   └── ContentView.swift      — корневой экран (TabView / NavigationSplitView)
├── Models.swift               — модели данных (Product, CartItem, Enums)
├── ShopStore.swift            — хранилище состояния (@Observable)
├── Theme.swift                — цвета бренда и ProductImageTile
├── CatalogView.swift          — каталог с адаптивной сеткой
├── ProductDetailView.swift    — карточка товара (side-by-side на iPad)
├── FavoritesView.swift        — избранные товары
├── CartView.swift             — корзина и оформление заказа
└── CustomOrderView.swift      — форма кастомного заказа
```

## Запуск

1. Открыть `2Sick.xcodeproj` в Xcode 16+
2. Выбрать симулятор или устройство с iOS 17+
3. Запустить (⌘R)

## Автор

[mhg77](https://github.com/mhg77)
