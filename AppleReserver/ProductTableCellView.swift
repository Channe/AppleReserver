//
//  TargetTableCellView.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/7.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import AppKit

class TargetTableCellView: NSTableCellView {
    static let identifier = NSUserInterfaceItemIdentifier("TargetTableCellView")

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.lightGray.withAlphaComponent(0.1).setFill()
        NSBezierPath(roundedRect: dirtyRect.insetBy(dx: 4.0, dy: 2.0), xRadius: 4.0, yRadius: 4.0).fill()
    }
}
