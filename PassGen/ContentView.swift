//
//  ContentView.swift
//  PassGen
//
//  Created by Kauntey Suryawanshi on 27/10/25.
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
		VStack(alignment: .leading, spacing: 10) {
			VStack(spacing: 10) {
				TextEditor(text: $passText)
					.font(.largeTitle)
					.padding(5)
					.overlay(content: {
						RoundedRectangle(cornerRadius: 12)
							.stroke(.secondary)
					})
					.overlay(alignment: .bottomTrailing, content: {
						Button(action: {
							let pb = NSPasteboard.general
							pb.clearContents()
							pb.setString(self.passText, forType: .string)
						}) {
							Image(systemName: "document.on.clipboard")
								.imageScale(.large)
						}
						.padding(7)
						.help("Copy password")
						.opacity(passText.isEmpty ? 0 : 1)
						.animation(.default, value: passText)
					})
					.frame(minHeight: 200)
				Button(action: {
					self.passText = self.passwordGenerator(
						upperCase: self.upperCase,
						lowerCase: self.lowerCase,
						numbers: self.numbers,
						symbols: self.symbols,
						length: Int(self.length)
					)
				}) {
					Text("Generate")
				}
				.buttonStyle(.borderedProminent)
				.controlSize(.extraLarge)
			}

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
			}
			.fixedSize()

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
		}
		.padding()
	}
}

#Preview {
    ContentView()
}
