//
//  CountdownDetailViewController.swift
//  Dodo
//
//  Created by Blake Andrew Price on 10/22/19.
//  Copyright © 2019 Blake Andrew Price. All rights reserved.
//

import UIKit

class CountdownDetailViewController: UIViewController {
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var originalDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - Properties
    var countdownController: CountdownController?
    var countdown: Countdown?
    
    //MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let countdown = countdown {
            countdownController?.updateTitleOrDate(title: titleTextField.text ?? "",
                                                   dateAndTime: datePicker.date,
                                                   for: countdown)
        } else {
            countdownController?.createCountdown(title: titleTextField.text ?? "",
                                                 dateAndTime: datePicker.date)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Functions
    func updateViews() {
        if let countdown = countdown {
            titleTextField.text = countdown.title
            originalDateLabel.text = "Original: \(countdown.readableDate)"
            datePicker.date = countdown.dateAndTime
            navigationItem.title = "Edit Countdown"
        } else {
            navigationItem.title = "Add Countdown"
        }
    }
}
