//
//  ScrollView.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/8.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import AppKit

class ScrollView: NSScrollView {
    override var scrollerStyle: NSScroller.Style {
        // Forcing scroller style to overlay style
        // swiftlint:disable unused_setter_value computed_accessors_order
        set { super.scrollerStyle = .overlay }
        get { return .overlay }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.scrollerKnobStyle = .light
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.scrollerKnobStyle = .light
    }

    override func tile() {
        super.tile()
        self.contentView.frame = self.bounds
    }
}
