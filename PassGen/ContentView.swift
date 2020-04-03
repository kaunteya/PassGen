//
//  ContentView.swift
//  PassGen
//
//  Created by Kaunteya Suryawanshi on 03/04/20.
//  Copyright © 2020 Kaunteya Suryawanshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let passwordGenerator = PasswordGenerator()

    @State private var passText: String = ""
    @State private var upperCase = true
    @State private var lowerCase = true
    @State private var numbers = true
    @State private var symbols = true
    @State private var length: Float = 20

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 10) {
                TextField("A", text: $passText)
                Button(action: {
                    NSPasteboard.general.setString("Kola", forType: .string)
                }) {
                    Image("Copy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)

                }.buttonStyle(BorderlessButtonStyle())
                Button(action: {
                    self.passText = self.passwordGenerator(
                        upperCase: self.upperCase,
                        lowerCase: self.lowerCase,
                        numbers: self.numbers,
                        symbols: self.symbols,
                        length: Int(self.length)
                    )
                }) {
                    Image("Refresh")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                }.buttonStyle(BorderlessButtonStyle())
            }

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
                TextField("", value: $length, formatter: NumberFormatter()).frame(width: 40)
                Slider(value: $length, in: 1...99, step: 1)
            }
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
