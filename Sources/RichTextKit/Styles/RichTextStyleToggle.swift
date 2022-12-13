//
//  RichTextStyleToggle.swift
//  RichTextKit
//
//  Created by Daniel Saidi on 2022-12-08.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can be used to toggle a ``RichTextStyle`` value.

 This view renders a plain `Toggle` that uses a button style.
 This means that you can use and configure it as normal. The
 only exception is the tint, which is specified by the style
 that you can inject.

 Note that the view will use a ``RichTextStyleButton`` if it
 is used on iOS 14, macOS 11, tvOS 14 and watchOS 8.
 */
public struct RichTextStyleToggle: View {

    /**
     Create a rich text style toggle button.

     - Parameters:
       - style: The style to toggle.
       - buttonStyle: The button style to use, by default ``RichTextStyleToggle/Style/standard``.
       - value: The value to bind to.
       - fillVertically: Whether or not fill up vertical space in a non-greedy way, by default `false`.
     */
    public init(
        style: RichTextStyle,
        buttonStyle: Style = .standard,
        value: Binding<Bool>,
        fillVertically: Bool = false
    ) {
        self.style = style
        self.buttonStyle = buttonStyle
        self.value = value
        self.fillVertically = fillVertically
    }

    /**
     Create a rich text style button.

     - Parameters:
       - style: The style to toggle.
       - buttonStyle: The button style to use, by default ``RichTextStyleToggle/Style/standard``.
       - context: The context to affect.
       - fillVertically: Whether or not fill up vertical space in a non-greedy way, by default `false`.
     */
    public init(
        style: RichTextStyle,
        buttonStyle: Style = .standard,
        context: RichTextContext,
        fillVertically: Bool = false
    ) {
        self.style = style
        self.buttonStyle = buttonStyle
        switch style {
        case .bold: self.value = context.isBoldBinding
        case .italic: self.value = context.isItalicBinding
        case .strikethrough: self.value = context.isStrikethroughBinding
        case .underlined: self.value = context.isUnderlinedBinding
        }
        self.fillVertically = fillVertically
    }

    private let style: RichTextStyle
    private let buttonStyle: Style
    private let value: Binding<Bool>
    private let fillVertically: Bool

    public var body: some View {
        #if os(tvOS)
        toggle
        #else
        if #available(iOS 15.0, macOS 12.0, watchOS 9.0, *) {
            toggle.toggleStyle(.button)
        } else {
            RichTextStyleButton(
                style: style,
                buttonStyle: .init(
                    inactiveColor: buttonStyle.inactiveColor,
                    activeColor: buttonStyle.activeColor),
                value: value
            )
        }
        #endif
    }

    private var toggle: some View {
        Toggle(isOn: value) {
            style.icon
                .frame(maxHeight: fillVertically ? .infinity : nil)
        }
        .tintColor(tintColor)
        .keyboardShortcut(for: style)
    }
}

private extension View {

    @ViewBuilder
    func tintColor(_ color: Color) -> some View {
        if #available(iOS 15.0, macOS 12.0, watchOS 9.0, *) {
            self.tint(color)
        } else {
            self.accentColor(color)
        }
    }

}

public extension RichTextStyleToggle {

    /**
     This style can be used to style a ``RichTextStyleToggle``.
     */
    struct Style {

        /**
         Create a rich text style button style.

         - Parameters:
           - inactiveColor: The color to apply when the button is inactive, by default `.primary`.
           - activeColor: The color to apply when the button is active, by default `.blue`.
         */
        public init(
            inactiveColor: Color = .primary,
            activeColor: Color = .blue
        ) {
            self.inactiveColor = inactiveColor
            self.activeColor = activeColor
        }

        /// The color to apply when the button is inactive.
        public var inactiveColor: Color

        /// The color to apply when the button is active.
        public var activeColor: Color
    }
}

public extension RichTextStyleToggle.Style {

    /**
     The standard ``RichTextStyleToggle`` style.
     */
    static var standard = RichTextStyleToggle.Style()
}

private extension RichTextStyleToggle {

    var isOn: Bool {
        value.wrappedValue
    }

    var tintColor: Color {
        isOn ? buttonStyle.activeColor : buttonStyle.inactiveColor
    }
}

struct RichTextStyleToggle_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var isBoldOn = false

        @State
        private var isItalicOn = true

        @State
        private var isStrikethroughOn = false

        @State
        private var isUnderlinedOn = false

        var body: some View {
            HStack {
                RichTextStyleToggle(
                    style: .bold,
                    value: $isBoldOn)
                RichTextStyleToggle(
                    style: .italic,
                    value: $isItalicOn)
                RichTextStyleToggle(
                    style: .strikethrough,
                    value: $isStrikethroughOn)
                RichTextStyleToggle(
                    style: .underlined,
                    value: $isUnderlinedOn)
            }.padding()
        }
    }

    static var previews: some View {
        Preview()
    }
}