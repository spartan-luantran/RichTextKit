//
//  RichTextContexts.swift
//  Demo
//
//  Created by Luan Tran on 15/12/24.
//  Copyright © 2024 Kankoda Sweden AB. All rights reserved.
//


import SwiftUI
import RichTextKit

class RichTextContexts: ObservableObject {
    @Published var contexts: [RichTextContext]
    
    init(count: Int) {
      self.contexts = (0..<count).map { _ in RichTextContext() }
    }
}
