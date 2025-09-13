# EasterEggs Swift Package
**Add Easter eggs to your iOS app.**

<img width="3658" height="1809" alt="Group 1321315437" src="https://github.com/user-attachments/assets/76fcbb81-84df-487a-be3a-d54bfbd5aa16" />

https://github.com/user-attachments/assets/fa158ef0-bdfc-4fa0-a295-08f69da0882a

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
                EasterEggsView(sceneStyle: .halloween)
            }
        }
    }
}

#Preview {
    ContentView()
}


`.onShakeOpenEasterEggs()` the modifier will open the eggs when the user shakes the phone.
