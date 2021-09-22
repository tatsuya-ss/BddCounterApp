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

private extension UIButton {
    func tap() {
        self.sendActions(for: .touchUpInside)
    }
}

final class CounterViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var vc: CounterViewController!
        
        beforeEach { ///確かitの前に毎回呼ばれるやつでテスト対象をセットアップする
            vc = CounterViewController.make()
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
        
        ///初期表示のテスト
        describe("初期表示") {
            it("カウントが「0」であること") {
                expect(vc.countLabel.text).to(equal("0"))
            }
        }
        
        ///「＋」ボタンをタップした時のテスト
        describe("「＋」ボタンのタップ") {
            context("現在地が「0」") {
                it("カウンタが「１」に増えること") {
                    vc.incrementButton.tap()
                    expect(vc.countLabel.text).to(equal("1"))
                }
            }
        }
        
        describe("「-」ボタンをタップ") {
            context("現在地が「1」") {
                beforeEach { ///事前に現在値を「１」にしておく処理
                    vc.incrementButton.tap()
                }
                
                it("カウンタが「0」に減ること") {
                    vc.decrementButton.tap()
                    expect(vc.countLabel.text).to(equal("0"))
                }
            }
        }
        
    }

}

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
