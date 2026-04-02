import SwiftUI
import CoreData

struct HomeView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var currentIndex = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Product Viewer")
                    .font(.largeTitle)
                    .bold()

                if !products.isEmpty {
                    let product = products[currentIndex]

                    VStack(alignment: .leading, spacing: 10) {
                        Text("ID: \(product.productID)")
                        Text("Name: \(product.name ?? "")")
                        Text("Description: \(product.productDescription ?? "")")
                        Text("Price: $\(product.price, specifier: "%.2f")")
                        Text("Provider: \(product.provider ?? "")")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    HStack(spacing: 20) {
                        Button("Previous") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .disabled(currentIndex == 0)

                        Button("Next") {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding(.top)

                } else {
                    Text("No products available.")
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(spacing: 4) {
                    Text("Arina Mirzakhani")
                        .font(.footnote)
                        .fontWeight(.semibold)

                    Text("Student ID: 101418340")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 10)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
