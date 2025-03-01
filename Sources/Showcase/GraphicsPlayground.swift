// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GraphicsPlayground: View {
    @State var isRotating3D = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Standard")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                }
                HStack {
                    Text(".grayscale(0.99)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.99)
                }
                HStack {
                    Text(".grayscale(0.25)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.25)
                }
                Text(".rotation3DEffects")
                Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(.degrees(isRotating3D ? 0.0 : 360.0), axis: (x: 0, y: 1, z: 0))
                    .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isRotating3D)
                    .onAppear { isRotating3D = true }
                Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .rotation3DEffect(.degrees(45.0), axis: (x: 1.0, y: 0.0, z: 0.0))
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GraphicsPlayground.swift")
        }
    }
}
