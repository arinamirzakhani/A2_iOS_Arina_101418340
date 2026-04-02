import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var sortOption = "ID"

    var sortedProducts: [Product] {
        switch sortOption {
        case "Name":
            return products.sorted { ($0.name ?? "") < ($1.name ?? "") }
        case "Price":
            return products.sorted { $0.price < $1.price }
        default:
            return products.sorted { $0.productID < $1.productID }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort By", selection: $sortOption) {
                    Text("ID").tag("ID")
                    Text("Name").tag("Name")
                    Text("Price").tag("Price")
                }
                .pickerStyle(.segmented)
                .padding()

                Text("Total Products: \(products.count)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                List {
                    ForEach(sortedProducts) { product in
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
