//
// The MIT License (MIT)
//
// Copyright (c) 2015 RxSwift Community
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import Reachability
import RxCocoa
import RxSwift

extension Reachability: ReactiveCompatible { }

public extension Reactive where Base: Reachability {

  static var reachabilityChanged: Observable<Reachability> {
    return NotificationCenter.default.rx.notification(Notification.Name.reachabilityChanged)
      .flatMap { notification -> Observable<Reachability> in
        guard let reachability = notification.object as? Reachability else {
          return .empty()
        }
        return .just(reachability)
    }
  }

  static var status: Observable<Reachability.Connection> {
    return reachabilityChanged
      .map { $0.connection }
  }

  static var isReachable: Observable<Bool> {
    return reachabilityChanged
        .map { $0.connection != .unavailable }
  }

  static var isConnected: Observable<Void> {
    return isReachable
      .filter { $0 }
      .map { _ in Void() }
  }

  static var isDisconnected: Observable<Void> {
    return isReachable
      .filter { !$0 }
      .map { _ in Void() }
  }

}

public extension Reactive where Base: Reachability {

  var reachabilityChanged: Observable<Reachability> {
    return NotificationCenter.default.rx.notification(Notification.Name.reachabilityChanged, object: base)
      .flatMap { notification -> Observable<Reachability> in
        guard let reachability = notification.object as? Reachability else {
          return .empty()
        }
        return .just(reachability)
    }
  }

  var status: Observable<Reachability.Connection> {
    return reachabilityChanged
      .map { $0.connection }
  }

  var isReachable: Observable<Bool> {
    return reachabilityChanged
        .map { $0.connection != .unavailable }
  }

  var isConnected: Observable<Void> {
    return isReachable
      .filter { $0 }
      .map { _ in Void() }
  }

  var isDisconnected: Observable<Void> {
    return isReachable
      .filter { !$0 }
      .map { _ in Void() }
  }

}
