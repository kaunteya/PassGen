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
		VStack(alignment: .leading, spacing: 30) {
			VStack(spacing: 10) {
				Text(passText)
					.textSelection(.enabled)
					.font(.largeTitle)
					.monospaced()
					.frame(maxWidth: .infinity, alignment: .topLeading)
					.padding(8)
					.frame(minHeight: 200, alignment: .topLeading)
					.overlay(content: {
						RoundedRectangle(cornerRadius: 12)
							.fill(.fill.tertiary)
					})
					.overlay(alignment: .bottomTrailing, content: {
						copyButton
					})
				Button(action: {
					updatePassText()
				}) {
					Text("Generate")
				}
				.buttonStyle(.borderedProminent)
				.controlSize(.extraLarge)
			}

			Divider()
			VStack(alignment: .leading, spacing: 10) {
				HStack(spacing: 20) {
					Toggle("Uppercase", isOn: $upperCase)
					Toggle("Lowercase", isOn: $lowerCase)
					Toggle("Numbers", isOn: $numbers)
					Toggle("Symbols", isOn: $symbols)
				}
				.fixedSize()
				.onChange(of: [upperCase, lowerCase, numbers, symbols]) {
					updatePassText()
				}

				HStack {
					Slider(value: $length, in: 10...50, step: 1) {
						Text("Password Length: ")
							.monospacedDigit()
					} onEditingChanged: { a in
						updatePassText()
					}
					TextField("", value: $length, formatter: NumberFormatter()).frame(width: 25)
				}
			}
		}
		.onAppear {
			updatePassText()
		}
		.padding()
		.padding(.bottom)
		.overlay(alignment: .bottomTrailing) {
			githubButton
		}
		.padding()

	}
	var githubButton: some View {
		Button(action: {
			let url = URL(string: "https://github.com/kaunteya/PassGen")!
			NSWorkspace.shared.open(url)
		}) {
			Label {
				Text("View on github")
			} icon: {
				Image(.githubMark)
					.resizable()
					.scaledToFit()
					.frame(height: 11)
			}
			.labelIconToTitleSpacing(2)
		}
		.buttonStyle(.link)
		.controlSize(.small)
		.frame(maxWidth: .infinity, alignment: .trailing)
	}

	var copyButton: some View {
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
		.focusEffectDisabled()
	}

	func updatePassText() {
		Task {
			for _ in 0..<10 {
				try? await Task.sleep(for: .milliseconds(20))
				withAnimation {
					self.passText = self.passwordGenerator(
						upperCase: self.upperCase,
						lowerCase: self.lowerCase,
						numbers: self.numbers,
						symbols: self.symbols,
						length: Int(self.length)
					)
				}

			}
		}
	}

}

#Preview {
    ContentView()
}
