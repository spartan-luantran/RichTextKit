//
//  TestView.swift
//  RichTextKit
//
//

import RichTextKit
import SwiftUI

struct TestView: View {
  
  @State private var text = NSAttributedString(string: "Type here...")
  @StateObject var context = RichTextContext()
  @State private var desiredHeight: CGFloat = 0
  
  var body: some View {
    VStack {
      RichTextEditor(
        text: $text,
        context: context,
        desiredHeight: $desiredHeight
      ).focusedValue(\.richTextContext, context)
        .border(.yellow)
        .richTextEditorConfig(RichTextEditorConfig(isScrollingEnabled: true))
        .frame(height: max(self.desiredHeight, 24))
      Spacer()
      
      HStack {
        Button("Bold") {
          context.handle(.setStyle(.bold, true))
        }
      }
    }.padding(24)
  }
}
