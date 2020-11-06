//
//  AppViewController.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import AppKit
import ReSwift
import Kingfisher

class AppViewController: NSViewController {
    @IBOutlet weak var targetsTableView: NSTableView!
    @IBOutlet weak var notificationButton: NSButton!
    @IBOutlet weak var intervalButton: NSPopUpButton!
    @IBOutlet weak var toggleButton: NSButton!
    @IBOutlet weak var indicator: NSProgressIndicator!

    private var pollingTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        App.store.subscribe(self)
    }

    // MARK: Event method
    @IBAction func toggleAction(_ sender: NSButton) {
        let interval = Double(self.intervalButton.titleOfSelectedItem ?? "3") ?? 3.0
        if self.pollingTimer?.isValid == true {
            sender.title = "开始"
            self.intervalButton.isEnabled = true
            self.indicator.stopAnimation(sender)
            self.pollingTimer?.invalidate()
            self.pollingTimer = nil
        } else {
            sender.title = "停止"
            self.intervalButton.isEnabled = false
            self.indicator.startAnimation(sender)
            self.pollingTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
                App.store.dispatch(AppAction.ReloadAvailabilites())
            }
            self.pollingTimer?.fire()
        }
    }
}

extension AppViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return App.store.state.targets.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let target = Array(App.store.state.targets)[row]
        let view = tableView.makeView(withIdentifier: TargetTableCellView.identifier, owner: self) as? TargetTableCellView
        view?.productNameLabel.stringValue = target.product.description
        view?.locationLabel.stringValue = "\(target.region.name) - \(target.store.storeName)"
        view?.productImageView.kf.setImage(with: target.product.image, options: [.processor(RoundCornerImageProcessor(cornerRadius: 20.0))])
        if let available = target.available {
            view?.statusLabel.stringValue = available ? "有货" : "无货"
            view?.statusLabel.textColor = available ? .green : .red
        } else {
            view?.statusLabel.stringValue = "未知"
            view?.statusLabel.textColor = .textColor
        }
        view?.deleteHandler = {
            App.store.dispatch(AppAction.RemoveTarget(index: row))
        }
        return view
    }
}

extension AppViewController: StoreSubscriber {
    func newState(state: AppState) {
        self.targetsTableView.reloadData()
    }
}
