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
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        updateViews()
        
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var originalDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    //MARK: - Properties
    var countdownController: CountdownController?
    var countdown: Countdown?
    
    //MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: Any) {
        if titleTextField.text == "" {
            let alert = UIAlertController(title: "Countdown has no title.", message: "Please give your countdown a title!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "I will add a title!", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let categoryIndex = categoryPicker.selectedRow(inComponent: 0)
        let categoryCase = Category.allCases[categoryIndex]
        if let countdown = countdown {
            countdownController?.updateCountdown(title: titleTextField.text ?? "",
                                                   dateAndTime: datePicker.date,
                                                   category: categoryCase,
                                                   for: countdown)
        } else {
            countdownController?.createCountdown(title: titleTextField.text ?? "",
                                                 dateAndTime: datePicker.date,
                                                 category: categoryCase)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Functions
    func updateViews() {
        if let countdown = countdown {
            titleTextField.text = countdown.title
            originalDateLabel.text = "Original: \(countdown.readableDate)"
            datePicker.date = countdown.dateAndTime
            categoryPicker.selectRow(Category.allCases.firstIndex(of: countdown.category)!, inComponent: 0, animated: false)
            navigationItem.title = "Edit Countdown"
        } else {
            navigationItem.title = "Add Countdown"
        }
    }
}

extension CountdownDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
}

extension CountdownDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let selectedCase = Category.allCases[row]
        return selectedCase.rawValue.capitalized
    }
}
