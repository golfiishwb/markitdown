import SwiftUI

struct ContentView: View {
    var body: some View {
        WebView(htmlResourceName: "index")
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
