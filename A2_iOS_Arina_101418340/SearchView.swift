import SwiftUI
import CoreData

struct SearchView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var searchText = ""

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.name ?? "").localizedCaseInsensitiveContains(searchText) ||
                ($0.productDescription ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search by name or description", text: $searchText)
                        .textFieldStyle(.roundedBorder)

                    if !searchText.isEmpty {
                        Button("Clear") {
                            searchText = ""
                        }
                    }
                }
                .padding()

                if filteredProducts.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 36))
                            .foregroundColor(.gray)

                        Text("No products found")
                            .font(.headline)

                        Text("Try a different search term.")
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)

                    Spacer()
                } else {
                    List {
                        ForEach(filteredProducts) { product in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.name ?? "Unknown Product")
                                    .font(.headline)

                                Text(product.productDescription ?? "No description")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Products")
        }
    }
}
