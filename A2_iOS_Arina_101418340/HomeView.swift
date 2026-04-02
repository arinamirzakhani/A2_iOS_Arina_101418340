import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var currentIndex: Int = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Product Viewer")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if products.isEmpty {
                    Text("No products available")
                        .foregroundColor(.gray)
                } else {
                    let currentProduct = products[currentIndex]

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Product ID: \(currentProduct.productID)")
                        Text("Name: \(currentProduct.name ?? "")")
                        Text("Description: \(currentProduct.productDescription ?? "")")
                        Text(String(format: "Price: $%.2f", currentProduct.price))
                        Text("Provider: \(currentProduct.provider ?? "")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(12)

                    HStack(spacing: 20) {
                        Button("Previous") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(currentIndex == 0)

                        Button("Next") {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(currentIndex == products.count - 1)
                    }

                    Text("Showing \(currentIndex + 1) of \(products.count)")
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
