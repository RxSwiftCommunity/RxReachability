//
//  ViewController.swift
//  RxReachability
//
//  Created by ivanbruel on 03/22/2017.
//  Copyright (c) 2017 ivanbruel. All rights reserved.
//

import UIKit
import ReachabilitySwift
import RxSwift
import RxCocoa
import RxReachability

class ViewController: UIViewController {

  @IBOutlet private weak var label: UILabel!

  let reachability = Reachability()!
  let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    reachability.rx.isReachable
      .map { "Is reachable: \($0)" }
      .bindTo(label.rx.text)
      .addDisposableTo(disposeBag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    try? reachability.startNotifier()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    reachability.stopNotifier()
  }
}

