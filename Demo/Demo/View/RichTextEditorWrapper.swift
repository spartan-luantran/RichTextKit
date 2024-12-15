//
//  RichTextEditorWrapper.swift
//  Demo
//
//


import SwiftUI
import RichTextKit

struct RichTextEditorWrapper: View {
    @Binding var text: NSAttributedString
    @ObservedObject var context: RichTextContext
    @Binding var desiredHeight: CGFloat
  var onEditingChanged: (_ isEditing: Bool) -> Void
    
    var body: some View {
        RichTextEditor(
            text: $text,
            context: context,
            desiredHeight: $desiredHeight
        )
        .focusedValue(\.richTextContext, context)
        .border(Color.yellow)
        .richTextEditorConfig(RichTextEditorConfig(isScrollingEnabled: false))
        .frame(height: max(desiredHeight, 24))
        .onChange(of: context.isEditingText) { isEditing in
          onEditingChanged(isEditing)
        }
    }
}
