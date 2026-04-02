import SwiftUI
import CoreData

struct SearchView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var searchText: String = ""

    // Filter logic
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter { product in
                let name = product.name?.lowercased() ?? ""
                let description = product.productDescription?.lowercased() ?? ""
                return name.contains(searchText.lowercased()) ||
                       description.contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // 🔍 Search bar
                TextField("Search by name or description", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                // 📋 Results
                if filteredProducts.isEmpty {
                    
                    Spacer()
                    
                    Text("No products found")
                        .foregroundColor(.gray)
                        .font(.headline)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(filteredProducts) { product in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.name ?? "Unknown Product")
                                    .font(.headline)

                                Text(product.productDescription ?? "No description")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text("Provider: \(product.provider ?? "")")
                                    .font(.caption)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
