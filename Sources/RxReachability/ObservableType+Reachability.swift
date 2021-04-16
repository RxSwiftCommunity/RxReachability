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

public extension ObservableType {

  /// An oberverable to execute retry and execute code on reconnect after a timeout `timeout`
  /// - Parameter timeout: Seconds for timeout
  /// - Returns: An observable sequence with a RxError.timeout in case of a timeout.
  func retryOnConnect(timeout: DispatchTimeInterval) -> Observable<Element> {
    return retry { _ in
      return Reachability.rx.isConnected
        .timeout(timeout, scheduler: MainScheduler.asyncInstance)
    }
  }

  /// An filtered oberverable to execute retry and execute code on reconnect after a timeout `timeout`
  /// - Parameters:
  ///   - timeout: Seconds for timeout
  ///   - predicate: A function to test each source element for a condition.
  /// - Returns: An observable sequence producing the elements of the given sequence repeatedly until it terminates successfully or is notified to error or complete.
  func retryOnConnect(
    timeout: DispatchTimeInterval,
    predicate: @escaping (Swift.Error) -> Bool
  ) -> Observable<Element> {
    return retry {
      return $0
        .filter(predicate)
        .flatMap { _ in
          Reachability
            .rx
            .isConnected
            .timeout(
              timeout,
              scheduler: MainScheduler.asyncInstance
          )
        }
    }
  }

  /// An filtered oberverable to execute retry and execute code on reconnect after a timeout `timeout`
  /// - Parameters:
  ///   - timeout: Seconds for timeout
  ///   - predicate: A function to test each source element for a condition.
  /// - Returns: An observable sequence whose elements are the result of invoking the transform function on each element of source producing an Observable of Observable sequences and that at any point in time produces the elements of the most recent inner observable sequence that has been received.
  func retryLatestOnConnect(
    timeout: DispatchTimeInterval,
    predicate: @escaping (Swift.Error) -> Bool
  ) -> Observable<Element> {
    return retry {
      return $0
        .filter(predicate)
        .flatMapLatest { _ in
          Reachability
            .rx
            .isConnected
            .timeout(
              timeout,
              scheduler: MainScheduler.asyncInstance
            )
        }
    }
  }
}
