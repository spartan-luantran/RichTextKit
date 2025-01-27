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
            ).border(.gray)
          }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 24, trailing: 24))
      }
      .scrollIndicators(.never)
      HStack {
        Button(action: {
          viewModel.applyBold()
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
}

