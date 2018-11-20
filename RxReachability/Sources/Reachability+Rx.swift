//
//  Reachability+Rx.swift
//
//  Created by Ivan Bruel on 22/03/2017.
//  Copyright (c) RxSwiftCommunity. All rights reserved.
//

import Foundation
import Reachability
import RxCocoa
import RxSwift

extension Reachability: ReactiveCompatible { }

public extension Reactive where Base: Reachability {

  public static var reachabilityChanged: Observable<Reachability> {
    return NotificationCenter.default.rx.notification(Notification.Name.reachabilityChanged)
      .flatMap { notification -> Observable<Reachability> in
        guard let reachability = notification.object as? Reachability else {
          return .empty()
        }
        return .just(reachability)
    }
  }

  public static var status: Observable<Reachability.Connection> {
    return reachabilityChanged
      .map { $0.connection }
  }

  public static var isReachable: Observable<Bool> {
    return reachabilityChanged
      .map { $0.connection != .none }
  }

  public static var isConnected: Observable<Void> {
    return isReachable
      .filter { $0 }
      .map { _ in Void() }
  }

  public static var isDisconnected: Observable<Void> {
    return isReachable
      .filter { !$0 }
      .map { _ in Void() }
  }
}

public extension Reactive where Base: Reachability {

  public var reachabilityChanged: Observable<Reachability> {
    return NotificationCenter.default.rx.notification(Notification.Name.reachabilityChanged, object: base)
      .flatMap { notification -> Observable<Reachability> in
        guard let reachability = notification.object as? Reachability else {
          return .empty()
        }
        return .just(reachability)
    }
  }

  public var status: Observable<Reachability.Connection> {
    return reachabilityChanged
      .map { $0.connection }
  }

  public var isReachable: Observable<Bool> {
    return reachabilityChanged
      .map { $0.connection != .none }
  }

  public var isConnected: Observable<Void> {
    return isReachable
      .filter { $0 }
      .map { _ in Void() }
  }

  public var isDisconnected: Observable<Void> {
    return isReachable
      .filter { !$0 }
      .map { _ in Void() }
  }
}

