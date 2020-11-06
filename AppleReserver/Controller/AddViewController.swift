//
//  AddViewController.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/8.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import AppKit
import ReSwift

class AddViewController: NSViewController {
    @IBOutlet weak var regionButton: NSPopUpButton!
    @IBOutlet weak var storeButton: NSPopUpButton!
    @IBOutlet weak var productButton: NSPopUpButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        App.store.subscribe(self) { $0.skip(when: { $0.stores == $1.stores })}
        self.regionButton.menu?.items = App.store.state.regions.map {
            let item = NSMenuItem()
            item.title = $0.name
            item.identifier = NSUserInterfaceItemIdentifier($0.code)
            return item
        }
        self.productButton.menu?.items = App.store.state.products.map {
            let item = NSMenuItem()
            item.title = $0.description
            item.identifier = NSUserInterfaceItemIdentifier($0.partNumber)
            return item
        }
        self.regionButton.select(nil)
        self.storeButton.select(nil)
        self.productButton.select(nil)
    }

    @IBAction func didSelectRegionButton(_ sender: NSPopUpButton) {
        guard
            let identifier = sender.selectedItem?.identifier,
            let region = App.store.state.regions.first(where: { $0.code == identifier.rawValue })
        else {
            return
        }
        App.store.dispatch(AppAction.FetchStore(region: region))
    }

    @IBAction func didTapAddButton(_ sender: Any) {
        defer {
            self.dismiss(nil)
        }
        guard
            let regionIdentifier = self.regionButton.selectedItem?.identifier,
            let region = App.store.state.regions.first(where: { $0.code == regionIdentifier.rawValue }),
            let storeIdentifier = self.storeButton.selectedItem?.identifier,
            let store = App.store.state.stores?.stores.first(where: { $0.storeNumber == storeIdentifier.rawValue }),
            let productIdentifier = self.productButton.selectedItem?.identifier,
            let product = App.store.state.products.first(where: { $0.partNumber == productIdentifier.rawValue })
        else {
            return
        }
        App.store.dispatch(AppAction.AddTarget(target: .init(region: region, store: store, product: product)))
    }
}

extension AddViewController: StoreSubscriber {
    func newState(state: AppState) {
        self.storeButton.menu?.items = (App.store.state.stores?.stores ?? []).map {
            let item = NSMenuItem()
            item.title = $0.storeName
            item.identifier = NSUserInterfaceItemIdentifier($0.storeNumber)
            return item
        }
    }
}
