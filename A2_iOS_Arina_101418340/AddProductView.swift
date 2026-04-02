import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var productID: String = ""
    @State private var name: String = ""
    @State private var productDescription: String = ""
    @State private var price: String = ""
    @State private var provider: String = ""

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Product ID", text: $productID)
                        .keyboardType(.numberPad)

                    TextField("Product Name", text: $name)
                    TextField("Product Description", text: $productDescription)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)

                    TextField("Provider", text: $provider)
                }

                Section {
                    Button("Add Product") {
                        addProduct()
                    }
                }
            }
            .navigationTitle("Add Product")
            .alert("Message", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func addProduct() {
        guard let productIDValue = Int64(productID),
              let priceValue = Double(price),
              !name.isEmpty,
              !productDescription.isEmpty,
              !provider.isEmpty else {
            alertMessage = "Please fill in all fields correctly."
            showAlert = true
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.productID = productIDValue
        newProduct.name = name
        newProduct.productDescription = productDescription
        newProduct.price = priceValue
        newProduct.provider = provider

        do {
            try viewContext.save()
            alertMessage = "Product added successfully."

            productID = ""
            name = ""
            productDescription = ""
            price = ""
            provider = ""

            showAlert = true
        } catch {
            alertMessage = "Failed to save product."
            showAlert = true
        }
    }
}
