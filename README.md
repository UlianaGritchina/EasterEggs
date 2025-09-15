# EasterEggs Swift Package
**Add Easter eggs to your iOS app.**

<img width="3658" height="1809" alt="Group 1321315438" src="https://github.com/user-attachments/assets/90913238-f9a3-4707-a1c0-97339cad8fc4" />

https://github.com/user-attachments/assets/139d3221-82ac-4f76-94dd-ab6a76fca3b6

```
import EasterEggs
import SwiftUI

struct ContentView: View {
    
    @State private var isOpenEggs = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { isOpenEggs = true }) {
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
```
#### Beat the eggs.
`.onShakeOpenEasterEggs()` viewModifire opens the EasterEggsView when the user shakes the device.

```
import EasterEggs
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your awesome content")
            }
            .navigationTitle("Your app")
            .onShakeOpenEasterEggs()
        }
    }
}

#Preview {
    ContentView()
}
```
#### Use different scene styles, including custom.
**SceneStyle:**
- `.base`
- `.christmas`
- `.halloween`
- `.watermelons`
- `.custom(backgroundImageName: String, eggsImages: [String])`
```
EasterEggsView(sceneStyle: .christmas)
```
```
EasterEggsView(
    sceneStyle: .custom(
        backgroundImageName: "yourCustomBackground",
        eggsImages: ["yourCustomEgg1", "yourCustomEgg2", "yourCustomEgg3"]
    )
)
```
