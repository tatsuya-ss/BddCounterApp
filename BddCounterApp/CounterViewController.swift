//
//  CounterViewController.swift
//  BddCounterApp
//
//  Created by 坂本龍哉 on 2021/09/21.
//

import UIKit

protocol CounterStorage {
    func save(_ count: Int)
}

final class CounterStorageMock: CounterStorage {
    var latestSaveCount: Int?
    
    func save(_ count: Int) {
        latestSaveCount = count
    }
}

final class CounterStorageDefaults: CounterStorage {
    func save(_ count: Int) {
        UserDefaults.standard.set(count, forKey: "count")
    }
}

final class Counter {
    private(set) var count: Int
    private let counterStorage: CounterStorage

    init(count: Int = 0,
         counterStorage: CounterStorage = CounterStorageDefaults()) {
        self.count = count
        self.counterStorage = counterStorage
    }
    
    var isLowerLimit: Bool { return count == 0 }
    var isUpperLimit: Bool { return count == 10 }
    
    func increment() {
        count += 1
        counterStorage.save(count)
    }
    
    func decrement() {
        count -= 1
        counterStorage.save(count)
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
        
        decrementButton.isEnabled = !counter.isLowerLimit
        incrementButton.isEnabled = !counter.isUpperLimit
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
