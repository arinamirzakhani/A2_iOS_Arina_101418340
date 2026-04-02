import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    var body: some View {
        NavigationStack {
            List {
                ForEach(products) { product in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(product.name ?? "Unknown Product")
                            .font(.headline)

                        Text(product.productDescription ?? "No description")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(String(format: "$%.2f", product.price))
                            .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("All Products")
        }
    }
}
