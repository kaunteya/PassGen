//
//  ContentView.swift
//  PassGen
//
//  Created by Kaunteya Suryawanshi on 03/04/20.
//  Copyright © 2020 Kaunteya Suryawanshi. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    let passwordGenerator = PasswordGenerator()

    @State private var passText: String = ""
    @State private var upperCase = true
    @State private var lowerCase = true
    @State private var numbers = true
    @State private var symbols = true
    @State private var length: Float = 20

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                TextField("", text: $passText)
                Button(action: {
                    self.passText = self.passwordGenerator(
                        upperCase: self.upperCase,
                        lowerCase: self.lowerCase,
                        numbers: self.numbers,
                        symbols: self.symbols,
                        length: Int(self.length)
                    )
                    UserDefaults.generateCount += 1
                }) {
                    Text("Generate")
                }
            }
            Button(action: {
                let pb = NSPasteboard.general
                pb.clearContents()
                pb.setString(self.passText, forType: .string)
            }) {
                Text("Copy password")

            }.buttonStyle(LinkButtonStyle())

            Divider()
            HStack(spacing: 20) {
                Toggle(isOn: $upperCase) {
                    Text("Uppercase")
                }
                Toggle(isOn: $lowerCase) {
                    Text("Lowercase")
                }
                Toggle(isOn: $numbers) {
                    Text("Numbers")
                }
                Toggle(isOn: $symbols) {
                    Text("Symbols")
                }
            }.fixedSize()
            HStack {
                Text("Password Length:")
                TextField("", value: $length, formatter: NumberFormatter()).frame(width: 25)
                Slider(value: $length, in: 1...99)
            }
            HStack {
                Spacer()
                Button(action: {
                    let url = URL(string: "https://github.com/kaunteya/PassGen")!
                    NSWorkspace.shared.open(url)
                }) {
                    Text("View on github")

                }.buttonStyle(LinkButtonStyle()).font(Font.system(size: 10))
            }
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 2, trailing: 20))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
