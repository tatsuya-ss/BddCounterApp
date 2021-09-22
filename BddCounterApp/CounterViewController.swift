//
//  CounterViewController.swift
//  BddCounterApp
//
//  Created by 坂本龍哉 on 2021/09/21.
//

import UIKit

final class Counter {
    private(set) var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
    
    var isNotLowerLimit: Bool { return count > 0 }
    var isNotUpperLimit: Bool { return count < 10 }
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
}

final class CounterViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    
    var counter = Counter()
    
    static func make() -> CounterViewController {
        let stotyboard = UIStoryboard(name: "Counter",
                                      bundle: nil)
        return stotyboard.instantiateInitialViewController() as! CounterViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        countLabel.text = "\(counter.count)"
        
        decrementButton.isEnabled = counter.isNotLowerLimit
        incrementButton.isEnabled = counter.isNotUpperLimit
    }
    
    @IBAction private func didTapIncrementButton(_ sender: Any) {
        counter.increment()
        updateView()
    }
    
    @IBAction private func didTapDecrementButton(_ sender: Any) {
        counter.decrement()
        updateView()
    }
    
}
