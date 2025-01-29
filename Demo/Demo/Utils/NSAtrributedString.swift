//
//  NSAtrributedString.swift
//  Demo
//
//  Created by Luan Tran on 29/1/25.
//  Copyright © 2025 Kankoda Sweden AB. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
  func changeFont(to newFont: UIFont) -> NSAttributedString {
    let mutableAttributedString = NSMutableAttributedString(attributedString: self)
    let range = NSRange(location: 0, length: self.length)
    
    mutableAttributedString.enumerateAttribute(.font, in: range, options: []) { value, subRange, _ in
      guard let currentFont = value as? UIFont else { return }
      
      let currentDescriptor = currentFont.fontDescriptor
      let traits = currentDescriptor.symbolicTraits
      let isBoldOrItalic = traits.contains(.traitBold) || traits.contains(.traitItalic)
      if isBoldOrItalic {
        let adjustedFont = UIFont(descriptor: currentDescriptor, size: newFont.pointSize)
        mutableAttributedString.addAttribute(.font, value: adjustedFont, range: subRange)
      } else {
        mutableAttributedString.addAttribute(.font, value: newFont, range: subRange)
      }
    }
    return mutableAttributedString
  }
  
  static func fromHTML(_ html: String, uniformFont: UIFont? = nil, execute: @escaping (NSAttributedString) -> Void) {
    DispatchQueue.main.async {
      guard let data = html.data(using: .utf8) else {
        return execute(NSAttributedString())
      }
      let attributed = (try? NSAttributedString(
        data: data, options: [
          .documentType: NSAttributedString.DocumentType.html,
          .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
      )) ?? NSAttributedString()
      
      guard let uniformFont = uniformFont else {
        execute(attributed)
        return
      }
      execute(attributed.changeFont(to: uniformFont))
    }
  }
}
