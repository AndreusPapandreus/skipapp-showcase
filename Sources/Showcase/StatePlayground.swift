// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

class TapCountObservable: ObservableObject {
    @Published var tapCount = 0
}

struct TapCountStruct : Identifiable {
    var id = 0
    var tapCount = 0
}

class TapCountRepository: ObservableObject {
    @Published var items: [TapCountStruct] = []

    func add() {
        items.append(TapCountStruct(id: items.count))
    }

    func increment() {
        if !items.isEmpty {
            items[items.count - 1].tapCount += 1
        }
    }
}

struct StatePlayground: View {
    @State var tapCount = 0
    @State var hasStateTapped: Bool? // Test optional vars
    @StateObject var tapCountObservable = TapCountObservable()
    @State var tapCountStruct = TapCountStruct()
    @StateObject var tapCountRepository = TapCountRepository() // Test ForEach observable

    var body: some View {
        List {
            Section {
                NavigationLink("Push another", value: PlaygroundType.state)
            }
            Section {
                if hasStateTapped == true {
                    Text("State tap count: \(tapCount)")
                } else {
                    Text("Tap below to increment state tap count")
                }
                Button("State") {
                    tapCount += 1
                    hasStateTapped = true
                }
                StatePlaygroundBindingView(tapCount: $tapCount)
            }
            Section {
                Text("Observable tap count: \(tapCountObservable.tapCount)")
                Button("Observable") {
                    tapCountObservable.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountObservable.tapCount)
            }
            Section {
                Text("Struct tap count: \(tapCountStruct.tapCount)")
                Button("Struct") {
                    tapCountStruct.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountStruct.tapCount)
            }
            Section {
                ForEach(tapCountRepository.items) { item in
                    Text("Repository item tap count: \(item.tapCount)")
                }
                Button("Add item") { tapCountRepository.add() }
                Button("Increment last") { tapCountRepository.increment() }
            }
        }
        .onChange(of: tapCount) {
            logger.log("onChange(of: tapCount): \($0)")
        }
        .onChange(of: tapCountObservable.tapCount) {
            logger.log("onChange(of: tapCountObservable.tapCount): \($0)")
        }
        .onChange(of: tapCountStruct.tapCount) {
            logger.log("onChange(of: tapCountStruct.tapCount): \($0)")
        }
        .toolbar {
            PlaygroundSourceLink(file: "StatePlayground.swift")
        }
    }
}

struct StatePlaygroundBindingView: View {
    @Binding var tapCount: Int
    var body: some View {
        Button("Binding") {
            tapCount += 1
        }
    }
}

