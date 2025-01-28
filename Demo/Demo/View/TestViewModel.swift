//
//  TestViewModel.swift
//  Demo
//
//  Created by Luan Tran on 16/12/24.
//  Copyright © 2024 Kankoda Sweden AB. All rights reserved.
//
import RichTextKit
import Combine
import Foundation
import UIKit
import SwiftUICore

class EditorData: ObservableObject, Identifiable, Hashable {
  let id: String
  @Published var text: NSAttributedString
  @Published var context: RichTextContext
  @Published var desiredHeight: CGFloat
  let richTextEditorStyle: RichTextEditorStyle
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    self.id = UUID().uuidString
    self.text = NSAttributedString(string: "Oi con song que con song que")
    self.context = RichTextContext()
    self.desiredHeight = 0
    let uiFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    self.richTextEditorStyle = RichTextEditorStyle(font: uiFont, placeholderFont: uiFont, placeholderColor: .red)
  }
  
  static func == (lhs: EditorData, rhs: EditorData) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  var attributedStringBinding: Binding<NSAttributedString> {
    Binding<NSAttributedString>(
      get: {
        return self.text
      },
      set: { newValue in
        self.text = newValue
      }
    )
  }
}

final class TestViewModel: ObservableObject {
  // Outputs
  @Published var datas: [EditorData] = []
  @Published var selectedContext: RichTextContext? = nil
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    for _ in 0..<3 {
      datas.append(EditorData())
    }
    
    for data in datas {
      data.context.$isEditingText.sink(receiveValue: { isEditing in
        guard isEditing else {
          return
        }
        self.selectedContext = data.context
      }).store(in: &cancellables)
    }
  }
  
  func addMore() {
    let data = EditorData()
    data.context.toggleIsEditing()
    datas.append(data)
  }
  
  func applyBold() {
    let url = URL(string: "https://google.com")!
    //selectedContext?.handle(.setURL(url))
    selectedContext?.handle(.setColor(.background, .red))
  }
}
