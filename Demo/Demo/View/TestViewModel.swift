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

class EditorData: ObservableObject, Identifiable, Hashable {
  let id: String
  @Published var text: NSAttributedString
  @Published var context: RichTextContext
  @Published var desiredHeight: CGFloat
  let richTextEditorStyle: RichTextEditorStyle
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    self.id = UUID().uuidString
    self.text = NSAttributedString(string: "")
    self.context = RichTextContext()
    self.desiredHeight = 0
    let uiFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    self.richTextEditorStyle = RichTextEditorStyle(font: uiFont)
    
    self.context.actionPublisher.sink(receiveValue: { action in
      print("New actions: \(action)")
    }).store(in: &cancellables)
  }
  
  static func == (lhs: EditorData, rhs: EditorData) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

final class TestViewModel: ObservableObject {
  // Outputs
  @Published var datas: [EditorData] = []
  @Published var selectedContext: RichTextContext? = nil
  
  init() {
    for _ in 0..<5 {
      datas.append(EditorData())
    }
  }
  
  func addMore() {
    let data = EditorData()
    data.context.toggleIsEditing()
    datas.append(data)
  }
}
