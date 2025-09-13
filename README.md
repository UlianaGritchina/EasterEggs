# EasterEggs Swift Package Mangager
**Add Easter eggs to your iOS app.**

<img width="3658" height="1809" alt="eggs" src="https://github.com/user-attachments/assets/10642214-8bc8-4d05-97d4-ff0dd06cac4d" />

```
import EasterEggs
import SwiftUI

struct ContentView: View {
    
    @State private var isOpenEggs = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { isOpenEggs = true  }) {
                    Text("Open eggs")
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Your app")
            .fullScreenCover(isPresented: $isOpenEggs) {
                EasterEggsView()
            }
        }
    }
}

#Preview {
    ContentView()
}

```
