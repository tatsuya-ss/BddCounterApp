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
    func tap(repeat: Int = 1) {
        for _ in 1...`repeat` {
            self.sendActions(for: .touchUpInside)
        }
    }
}

final class CounterSpec: QuickSpec {
    override func spec() {
        
        describe("#init") {
            context("引数なしで初期化") {
                it("countが「0」であること") {
                    expect(Counter().count).to(equal(0))
                }
            }
            
            context("引数「5」で初期化") {
                it("countが「5」であること") {
                    expect(Counter(count: 5).count).to(equal(5))
                }
            }
        }
        
        describe("#increment / #decrement") {
            context("現在値が「5」") {
                var counter: Counter!
                
                beforeEach {
                    counter = Counter(count: 5)
                }
                
                it("incrementすると6になること") {
                    counter.increment()
                    expect(counter.count).to(equal(6))
                }
                
                it("decrementすると4になること") {
                    counter.decrement()
                    expect(counter.count).to(equal(4))
                }
            }
        }
        
        describe("#isLowerLimit") {
            context("現在地が「0」") {
                it("trueを返すこと") {
                    expect(Counter().isLowerLimit).to(beTrue())
                }
            }
            
            context("現在地が「1」以上") {
                it("falseを返すこと") {
                    expect(Counter(count: 1).isLowerLimit).to(beFalse())
                }
            }
        }
        
        describe("#isUpperLimit") {
            context("現在値が「10」") {
                it("trueを返すこと") {
                    expect(Counter(count: 10).isUpperLimit).to(beTrue())
                }
            }
            
            context("現在値が「10」未満") {
                it("falseを返すこと") {
                    expect(Counter(count: 9).isUpperLimit).to(beFalse())
                }
            }
        }
        
        describe("永続化") {
            context("現在値が「2」") {
                var counter: Counter!
                var counterStorageMock: CounterStorageMock!
                
                beforeEach {
                    counterStorageMock = CounterStorageMock()
                    counter = Counter(count: 2, counterStorage: counterStorageMock)
                }
                
                context("#incrementを呼び出す") {
                    it("CountStorage.save()が引数「3」で呼び出されること") {
                        counter.increment()
                        expect(counterStorageMock.latestSaveCount).to(equal(3))
                    }
                }
                
                context("#decrementを呼び出す") {
                    it("CounterStorage.save()が引数「1」で呼び出されること") {
                        counter.decrement()
                        expect(counterStorageMock.latestSaveCount).to(equal(1))
                    }
                }
                
            }
        }
        
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
            
            it("「-」ボタンが非活性であること") {
                expect(vc.decrementButton.isEnabled).to(beFalse())
            }
            
            it("「+」ボタンが活性であること") {
                expect(vc.incrementButton.isEnabled).to(beTrue())
            }
        }
        
        ///「＋」ボタンをタップした時のテスト
        describe("「＋」ボタンのタップ") {
            context("現在地が「0」") {
                it("カウンタが「１」に増えること") {
                    vc.incrementButton.tap()
                    expect(vc.countLabel.text).to(equal("1"))
                }
                
                it("下限値で無くなるので「-」ボタンが活性になること") {
                    vc.incrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beTrue())
                }
            }
            
            context("上限値に達した場合") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                }
                
                it("上限値なので「+」ボタンが非活性になること") {
                    expect(vc.countLabel.text).to(equal("10"))
                    expect(vc.incrementButton.isEnabled).to(beFalse())
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
                
                it("下限値になるので「-」ボタンが非活性になること") {
                    vc.decrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beFalse())
                }
            }
            
            context("現在地が「10」(上限値)") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                    vc.decrementButton.tap()
                }
                it("カウンタが「9」に減ること") {
                    expect(vc.countLabel.text).to(equal("9"))
                }
                
                it("上限値ではなくなるので「+」ボタンが活性になること") {
                    expect(vc.incrementButton.isEnabled).to(beTrue())
                }
            }
        }
        
        describe("現在値の保存") {
            context("現在値が2") {
                
                beforeEach {
                    vc.incrementButton.tap(repeat: 2)
                    UserDefaults.standard.set(0, forKey: "count")
                }
                
                context("「+」ボタンをタップ") {
                    it("現在値「3」がUserDefaultsに保存されていること") {
                        vc.incrementButton.tap()
                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(3))
                    }
                }
                
                context("「-」ボタンをタップ") {
                    it("現在値「1」がUserDefaultsに保存されていること") {
                        vc.decrementButton.tap()
                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(1))
                    }
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
