//
//  ContentView.swift
//  PassGen
//
//  Created by Kaunteya Suryawanshi on 03/04/20.
//  Copyright © 2020 Kaunteya Suryawanshi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var passText: String = ""

    @State private var upperCase = true
    @State private var lowerCase = true
    @State private var numbers = true
    @State private var symbols = true

    var body: some View {
        VStack(spacing: 20) {
            TextField("Generated password", text: $passText)
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
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
