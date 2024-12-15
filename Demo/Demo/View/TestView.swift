//
//  TestView.swift
//  RichTextKit
//
//

import SwiftUI
import RichTextKit

struct TestView: View {
  private let numberOfEditors = 5
  
  @State private var texts: [NSAttributedString] = Array(repeating: NSAttributedString(string: "Type here..."), count: 5)
  @StateObject private var contexts = RichTextContexts(count: 5)
  @State private var desiredHeights: [CGFloat] = Array(repeating: 24, count: 5)
  
  @State private var selectedEditorIndex: Int? = nil
  
  var body: some View {
    VStack {
      ScrollView {
        VStack(spacing: 16) {
          ForEach(0..<numberOfEditors, id: \.self) { index in
            RichTextEditorWrapper(
              text: $texts[index],
              context: contexts.contexts[index],
              desiredHeight: $desiredHeights[index],
              onEditingChanged: { editing in
                if editing {
                  selectedEditorIndex = index
                }x
              }
            )
            .background(
              RoundedRectangle(cornerRadius: 8)
                .stroke(selectedEditorIndex == index ? Color.blue : Color.gray, lineWidth: selectedEditorIndex == index ? 2 : 1)
            )
            .padding(.horizontal)
          }
        }
        .padding(.top)
      }
      
      HStack {
        Button(action: {
          applyBold()
        }) {
          Text("Bold")
            .fontWeight(.bold)
        }
      }
      .padding()
      .background(Color(UIColor.systemGray6))
      .cornerRadius(8)
      .padding(.bottom, 10)
    }
    .padding()
    .navigationTitle("Rich Text Editors")
  }
  
  private func applyBold() {
    guard let index = selectedEditorIndex else { return }
    contexts.contexts[index].handle(.setStyle(.bold, true))
  }
}

