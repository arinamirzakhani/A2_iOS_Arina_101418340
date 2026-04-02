import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var productID = ""
    @State private var name = ""
    @State private var productDescription = ""
    @State private var price = ""
    @State private var provider = ""

    var isFormValid: Bool {
        !productID.trimmingCharacters(in: .whitespaces).isEmpty &&
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !productDescription.trimmingCharacters(in: .whitespaces).isEmpty &&
        !price.trimmingCharacters(in: .whitespaces).isEmpty &&
        !provider.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Enter Product ID", text: $productID)
                        .keyboardType(.numberPad)

                    TextField("Enter Product Name", text: $name)

                    TextField("Enter Product Description", text: $productDescription)

                    TextField("Enter Product Price", text: $price)
                        .keyboardType(.decimalPad)

                    TextField("Enter Product Provider", text: $provider)
                }

                Section {
                    Button("Save Product") {
                        let newProduct = Product(context: viewContext)
                        newProduct.productID = Int16(productID) ?? 0
                        newProduct.name = name
                        newProduct.productDescription = productDescription
                        newProduct.price = Double(price) ?? 0.0
                        newProduct.provider = provider

                        do {
                            try viewContext.save()
                            productID = ""
                            name = ""
                            productDescription = ""
                            price = ""
                            provider = ""
                        } catch {
                            print("Error saving product: \(error)")
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Add Product")
        }
    }
}
