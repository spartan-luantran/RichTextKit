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
  
  @State private var texts: [NSAttributedString] = Array(repeating: NSAttributedString(string: "Type here..."), count: 5)
  @StateObject private var contexts = RichTextContexts(count: 5)
  @State private var desiredHeights: [CGFloat] = Array(repeating: 24, count: 5)
  
  @State private var selectedEditorIndex: Int? = nil
  @State var selectedContext: RichTextContext?
  
  var body: some View {
    VStack {
      ScrollView {
        VStack(spacing: 16) {
          ForEach(viewModel.datas, id: \.id) { data in
            RichTextEditorWrapper2(
              data: data,
              context: data.context,
              onEditingChanged: { editing in
                
              }
            )
          }
          /*
          ForEach(0..<numberOfEditors, id: \.self) { index in
            RichTextEditorWrapper(
              text: $texts[index],
              context: contexts.contexts[index],
              desiredHeight: $desiredHeights[index],
              onEditingChanged: { editing in
                if editing {
                  selectedEditorIndex = index
                }
              }
            )
            .background(
              RoundedRectangle(cornerRadius: 8)
                .stroke(selectedEditorIndex == index ? Color.blue : Color.gray, lineWidth: selectedEditorIndex == index ? 2 : 1)
            )
            .padding(.horizontal)
           
          }*/
        }
        .padding(.top)
      }
      
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

