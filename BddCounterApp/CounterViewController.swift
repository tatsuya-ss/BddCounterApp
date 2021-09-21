//
//  CounterViewController.swift
//  BddCounterApp
//
//  Created by 坂本龍哉 on 2021/09/21.
//

import UIKit

final class CounterViewController: UIViewController {
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var incrementButton: UIButton!
    @IBOutlet private weak var decrementButton: UIButton!
    
    static func make() -> CounterViewController {
        let stotyboard = UIStoryboard(name: "Counter",
                                      bundle: nil)
        return stotyboard.instantiateInitialViewController() as! CounterViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func didTapIncrementButton(_ sender: Any) {
        
    }
    
    @IBAction private func didTapDecrementButton(_ sender: Any) {
        
    }
    
}
