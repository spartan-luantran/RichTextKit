//
//  RichTextView+Theme.swift
//  RichTextKit
//
//  Created by Dominik Bucher on 13.02.2024.
//

#if iOS || macOS || os(tvOS) || os(visionOS)
import SwiftUI

public extension RichTextView {

    /// This type can configure a ``RichTextEditor`` theme.
    struct Theme {

        /// Create a custom configuration.
        ///
        /// - Parameters:
        ///   - font: default `.systemFont` of point size `16` (this differs on iOS and macOS).
        ///   - fontColor: default `.textColor`.
        ///   - backgroundColor: Color of whole textView default `.clear`.
        public init(
            font: FontRepresentable = .systemFont(ofSize: 16),
            fontColor: ColorRepresentable = .textColor,
            backgroundColor: ColorRepresentable = .clear,
            placeholderFont: FontRepresentable? = nil,
            placeholderColor: ColorRepresentable = .textColor.withAlphaComponent(0.8)
        ) {
            self.font = font
            self.fontColor = fontColor
            self.backgroundColor = backgroundColor
          self.placeholderFont = placeholderFont ?? font
          self.placeholderColor = placeholderColor
        }

        public let font: FontRepresentable
        public let fontColor: ColorRepresentable
        public let backgroundColor: ColorRepresentable
      public let placeholderFont: FontRepresentable
      public let placeholderColor: ColorRepresentable
    }
}

public extension RichTextView.Theme {

    /// The standard rich text view theme.
    static var standard: Self { .init() }
}
#endif
