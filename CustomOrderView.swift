//
//  CustomOrderView.swift
//  2Sick
//

import SwiftUI

struct CustomOrderView: View {
    @Environment(ShopStore.self) private var store
    @State private var name = ""
    @State private var contact = ""
    @State private var category: ProductCategory = .earrings
    @State private var comment = ""
    @State private var showSent = false

    private var canSubmit: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
            && !contact.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Контакты") {
                    TextField("Имя", text: $name)
                    TextField("Telegram или телефон", text: $contact)
                        .textInputAutocapitalization(.never)
                }
                .listRowBackground(Brand.card)

                Section("Что хотите заказать?") {
                    Picker("Тип изделия", selection: $category) {
                        ForEach(ProductCategory.allCases) { category in
                            Label(category.rawValue, systemImage: category.icon)
                                .tag(category)
                        }
                    }
                    TextField("Опишите вашу идею…", text: $comment, axis: .vertical)
                        .lineLimit(4...8)
                }
                .listRowBackground(Brand.card)

                Section {
                    Button {
                        showSent = true
                        name = ""
                        contact = ""
                        comment = ""
                    } label: {
                        Text("Отправить заявку")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 6)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Brand.pink)
                    .disabled(!canSubmit)
                    .listRowBackground(Color.clear)
                } footer: {
                    Text("Сделаем украшение по вашему эскизу. Ответим в течение дня.")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Brand.background)
            .navigationTitle("Кастом")
            .alert("Заявка отправлена!", isPresented: $showSent) {
                Button("Ок") {}
            } message: {
                Text("Мы свяжемся с вами, чтобы обсудить детали кастомного заказа.")
            }
        }
    }
}

#Preview {
    CustomOrderView()
        .environment(ShopStore())
        .preferredColorScheme(.dark)
}
