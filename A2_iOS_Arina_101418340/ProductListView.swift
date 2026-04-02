import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            VStack {
                Text("Total Products: \(products.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)

                List {
                    ForEach(products) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.name ?? "Unknown Product")
                                .font(.headline)

                            Text(product.productDescription ?? "No description")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            HStack {
                                Text("Provider: \(product.provider ?? "Unknown")")
                                Spacer()
                                Text("$\(product.price, specifier: "%.2f")")
                                    .fontWeight(.semibold)
                            }
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("All Products")
        }
    }
}
