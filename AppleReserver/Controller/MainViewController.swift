//
//  AppViewController.swift
//  AppleReserver
//
//  Created by Sunnyyoung on 2017/9/19.
//  Copyright © 2017年 Sunnyyoung. All rights reserved.
//

import AppKit
import ReSwift

class AppViewController: NSViewController {
    @IBOutlet weak var storesTableView: NSTableView!
    @IBOutlet weak var productsTableView: NSTableView!
    @IBOutlet weak var notificationButton: NSButton!
    @IBOutlet weak var intervalButton: NSPopUpButton!
    @IBOutlet weak var toggleButton: NSButton!
    @IBOutlet weak var indicator: NSProgressIndicator!

    override func viewDidLoad() {
        super.viewDidLoad()
        App.store.subscribe(self)
        App.store.dispatch(AppAction.FetchStore())
    }

    // MARK: Event method
    @IBAction func fireAction(_ sender: NSButton) {
//        let interval = Double(self.intervalButton.titleOfSelectedItem ?? "3") ?? 3.0
//        if self.pollingTimer?.isValid == true {
//            sender.title = "开始"
//            self.storesTableView.isEnabled = true
//            self.intervalButton.isEnabled = true
//            self.indicator.stopAnimation(sender)
//            self.pollingTimer = {
//                self.pollingTimer?.invalidate()
//                return nil
//            }()
//        } else {
//            sender.title = "停止"
//            self.storesTableView.isEnabled = false
//            self.intervalButton.isEnabled = false
//            self.indicator.startAnimation(sender)
//            self.pollingTimer = {
//                let timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(reloadAvailability), userInfo: nil, repeats: true)
//                timer.fire()
//                return timer
//            }()
//        }
    }

    @IBAction func reserveAction(_ sender: NSTableView) {
//        guard let url = self.reserveURL, sender.selectedRow >= 0 else {
//            return
//        }
//        NSWorkspace.shared.open(url)
    }
}

extension AppViewController: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        if tableView == self.storesTableView {
            return App.store.state.stores?.stores.count ?? 0
        } else if tableView == self.productsTableView {
            return App.store.state.products.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if tableView == self.storesTableView {
            guard let stores = App.store.state.stores?.stores else {
                return nil
            }
            let store = stores[row]
            return store.storeName
        } else if tableView == self.productsTableView  {
            let product = App.store.state.products[row]
            switch tableColumn?.identifier.rawValue {
            case "Monitoring":
                return false
            case "PartNumber":
                return product.partNumber
            case "Description":
                return product.description
            case "Capacity":
                return product.capacity
            case "Status":
                return product.available ? "有货" : "无货"
            default:
                return nil
            }
        } else {
            return nil
        }
    }

    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
//        let partNumber = self.availabilities[row].partNumber
//        guard let selected = object as? Bool else {
//            return
//        }
//        if selected {
//            self.selectedPartNumbers.insert(partNumber)
//        } else {
//            self.selectedPartNumbers.remove(partNumber)
//        }
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let tableView = notification.object as? NSTableView, tableView.selectedRow >= 0 else {
            return
        }
        if tableView == self.storesTableView {
            guard let stores = App.store.state.stores?.stores else {
                return
            }
            let store = stores[tableView.selectedRow]
            App.store.dispatch(AppAction.ReloadAvailabilites(storeNumber: store.storeNumber))
        } else if tableView == self.productsTableView {
//            let partNumber = self.availabilities[tableView.selectedRow].partNumber
//            guard let storeNumber = self.selectedStore?.storeNumber else {
//                return
//            }
//            self.reserveURL = URL(string: "https://reserve-prime.apple.com/CN/zh_CN/reserve/A/availability?path=/cn/shop/buy-iphone/\(storeNumber)&partNumber=\(partNumber)")
        }
    }
}

extension AppViewController: StoreSubscriber {
    func newState(state: AppState) {
        self.storesTableView.reloadData()
        self.productsTableView.reloadData()
    }
}
