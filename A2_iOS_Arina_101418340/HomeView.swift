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
                    Text("Product \(currentIndex + 1) of \(products.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    let product = products[currentIndex]

                    VStack(alignment: .leading, spacing: 12) {
                        Text(product.name ?? "Unknown Product")
                            .font(.title2)
                            .fontWeight(.bold)

                        Divider()

                        Text("ID: \(product.productID)")
                        Text("Description: \(product.productDescription ?? "")")
                        Text("Price: $\(product.price, specifier: "%.2f")")
                        Text("Provider: \(product.provider ?? "")")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    HStack(spacing: 12) {
                        Button("First") {
                            currentIndex = 0
                        }
                        .disabled(currentIndex == 0)

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

                        Button("Last") {
                            currentIndex = products.count - 1
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .buttonStyle(.bordered)
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)

                        Text("No products available")
                            .font(.headline)

                        Text("Please add a product from the Add tab.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
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
