// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import OSLog
import SwiftUI

let logger = Logger(subsystem: "app.ui", category: "AppUI")

enum PlaygroundType: String, CaseIterable {
    case color
    case font
    case button
    case toggle
    case textField
    case border
    case spacer
    case list
    case state
    case observable
}

enum ListPlaygroundType {
    case fixedContent
    case indexedContent
    case collectionContent
    case plainStyle
    case controls
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(PlaygroundType.allCases, id: \.rawValue) { playground in
                NavigationLink(value: playground) {
                    Text(playground.rawValue.capitalized)
                }
            }
            .navigationDestination(for: PlaygroundType.self) {
                switch $0 {
                case .color:
                    ColorPlayground()
                case .font:
                    FontPlayground()
                case .button:
                    ButtonPlayground()
                case .toggle:
                    TogglePlayground()
                case .textField:
                    TextFieldPlayground()
                case .border:
                    BorderPlayground()
                case .spacer:
                    SpacerPlayground()
                case .list:
                    ListPlayground()
                case .state:
                    StatePlayground()
                case .observable:
                    ObservablePlayground()
                }
            }
            .navigationDestination(for: ListPlaygroundType.self) {
                switch $0 {
                case .fixedContent:
                    FixedContentListPlayground()
                case .indexedContent:
                    IndexedContentListPlayground()
                case .collectionContent:
                    CollectionContentListPlayground()
                case .plainStyle:
                    PlainStyleListPlayground()
                case .controls:
                    ControlsListPlayground()
                }
            }
        }
    }
}
