//
//  BddCounterAppTests.swift
//  BddCounterAppTests
//
//  Created by 坂本龍哉 on 2021/09/21.
//

import XCTest
import Quick
import Nimble

@testable import BddCounterApp

final class CounterViewControllerTests: XCTestCase {
    
    func testIncremantButton() {
        /// test対象のVCを表示するため
        let vc = CounterViewController.make()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        /// 初期のカウントは「0」であること
        XCTAssertEqual(vc.countLabel.text, "0")
        
        /// 「+」ボタンをタップするとカウントが「1」に変化すること
        vc.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(vc.countLabel.text, "1") /// [失敗](まだ実装していないから)
    }
    
}

class BddCounterAppTests: XCTestCase { }
