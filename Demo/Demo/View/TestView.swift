//
//  TestView.swift
//  RichTextKit
//
//

import SwiftUI
import RichTextKit

struct TestView: View {
  private let numberOfEditors = 5
  
  @StateObject var viewModel = TestViewModel()
  
  @State private var texts: [NSAttributedString] = Array(repeating: NSAttributedString(string: ""), count: 5)
  @StateObject private var contexts = RichTextContexts(count: 5)
  @State private var desiredHeights: [CGFloat] = Array(repeating: 24, count: 5)
  
  @State private var selectedEditorIndex: Int? = nil
  @State var selectedContext: RichTextContext?
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVStack(alignment: .leading, spacing: 8) {
          ForEach(viewModel.datas, id: \.id) { data in
            RichTextEditorWrapper2(
              data: data,
              context: data.context,
              onEditingChanged: { editing in
                print("Is Editing: \(editing)")
              }
            )
          }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 24, trailing: 24))
      }
      .scrollIndicators(.never)
      HStack {
        Button(action: {
          //applyBold()
          // applyAlignCenter()
          viewModel.addMore()
        }) {
          Text("AlignCenter")
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
  
  private func applyAlignCenter() {
    guard let index = selectedEditorIndex else { return }
    
    contexts.contexts[index].handle(.setAlignment(.center))
  }
}

