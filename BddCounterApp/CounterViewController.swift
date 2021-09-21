//
//  CounterViewController.swift
//  BddCounterApp
//
//  Created by 坂本龍哉 on 2021/09/21.
//

import UIKit

final class CounterViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    
    var count = 0
    
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
        countLabel.text = "\(count)"
    }
    
    @IBAction private func didTapIncrementButton(_ sender: Any) {
        count += 1
        updateView()
    }
    
    @IBAction private func didTapDecrementButton(_ sender: Any) {
        
    }
    
}
