import SwiftUI

@main
struct MaskotaApp: App {
    var body: some Scene {
        WindowGroup {
            CatListAssembler().assemble()
        }
    }
}
