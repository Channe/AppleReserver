//
//  State.swift
//  AppleReserver
//
//  Created by Sunny Young on 2020/11/6.
//  Copyright © 2020 Sunnyyoung. All rights reserved.
//

import ReSwift
import Alamofire
import PromiseKit

enum AppError: Error {
    case invalidResponse
}

struct AppState: StateType {
    let regions: [Region]
    var stores: Stores?
    var products: [Product]
    var targets: [Target] = []

    init() {
        regions = [
            Region.china,
            Region.macau
        ]
        products = {
            do {
                guard let fileURL = Bundle.main.url(forResource: "Products", withExtension: "json") else {
                    return []
                }
                let fileData = try Data(contentsOf: fileURL)
                let products = try JSONDecoder().decode([Product].self, from: fileData)
                return products
            } catch {
                return []
            }
        }()
    }
}

struct AppAction {
    struct FetchStore: Action {
        let region: Region

        struct Success: Action {
            let stores: Stores
        }
        struct Failure: Action {
            let error: Error
        }
    }

    struct ReloadAvailabilites: Action {
        struct Success: Action {
            let targets: [Target]
        }
        struct Failure: Action {
            let error: Error
        }
    }

    struct AddTarget: Action {
        let target: Target
    }

    struct RemoveTarget: Action {
        let index: Int
    }
}

struct App {
    static let store = ReSwift.Store<AppState>(reducer: App.reducer, state: nil)

    static func reducer(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()
        switch action {
        case let action as AppAction.FetchStore:
            firstly {
                Alamofire.request(Apple.store(of: action.region)).responseDecodable(Stores.self)
            }.done { stores in
                App.store.dispatch(AppAction.FetchStore.Success(stores: stores))
            }.catch { error in
                App.store.dispatch(AppAction.FetchStore.Failure(error: error))
            }
        case let action as AppAction.FetchStore.Success:
            state.stores = action.stores
        case let action as AppAction.FetchStore.Failure:
            NSApp.presentError(action.error)
        case _ as AppAction.ReloadAvailabilites:
            func request(targets: [Target]) -> Promise<[Target]> {
                firstly {
                    Alamofire.request(Apple.availability(of: .china, series: "G")).responseJSON().map { $0.json }
                }.then { responseJSON -> Promise<[Target]> in
                    let targets: [Target] = state.targets.map {
                        guard
                            let responseJSON = responseJSON as? [String: Any],
                            let storesJSON = responseJSON["stores"] as? [String: Any],
                            let availabilitiesJSON = storesJSON[$0.store.storeNumber] as? [String: [String: Any]],
                            let availabilityJSON = availabilitiesJSON[$0.product.partNumber]?["availability"] as? [String: Any]
                        else {
                            return $0
                        }
                        var target = $0
                        let contract = (availabilityJSON["contract"] as? Bool) ?? false
                        let unlocked = (availabilityJSON["unlocked"] as? Bool) ?? false
                        target.available = contract || unlocked
                        return target
                    }
                    return .value(targets)
                }
            }
            firstly {
                request(targets: state.targets)
            }.done { targets in
                App.store.dispatch(AppAction.ReloadAvailabilites.Success(targets: targets))
            }.catch { error in
                App.store.dispatch(AppAction.ReloadAvailabilites.Failure(error: error))
            }
        case let action as AppAction.ReloadAvailabilites.Success:
            state.targets = action.targets
        case let action as AppAction.ReloadAvailabilites.Failure:
            NSApp.presentError(action.error)
        case let action as AppAction.AddTarget:
            state.targets.append(action.target)
        case let action as AppAction.RemoveTarget:
            state.targets.remove(at: action.index)
        default:
            break
        }
        return state
    }
}
