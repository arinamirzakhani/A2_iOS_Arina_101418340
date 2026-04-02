import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            AddProductView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
