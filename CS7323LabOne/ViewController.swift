//
//  ViewController.swift
//  CS7323LabOne
//
//  Created by Zhiwei Cheng on 9/18/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var timerLabel: UILabel!
    
    private var dates: [String] = []
    private var timer: Timer?
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        populateDates()
        startTimer()
    }
    
    private func setupPickerView() {
        datePicker.delegate = self
        datePicker.dataSource = self
    }
    
    private func populateDates() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dates = (0...6).compactMap {
            Calendar.current.date(byAdding: .day, value: -$0, to: Date()).map { formatter.string(from: $0) }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }
    
    @objc private func updateView() {
        counter += 1
        timerLabel.text = "Timer: \(counter) seconds"
        if counter == 10 { changeLabelStyle() }
    }
    
    private func changeLabelStyle() {
        timerLabel.textColor = .red
        timerLabel.font = .boldSystemFont(ofSize: 24)
        timerLabel.text = "Style Changed!"
    }
    
    // MARK: - UIPickerView DataSource & Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { dates.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dates[row]
    }
    
    // MARK: - Navigation Actions
    
    @IBAction func showWeatherTable(_ sender: UIButton) {
        if let weatherVC = storyboard?.instantiateViewController(withIdentifier: "WeatherTableViewController") as? WeatherTableViewController {
            weatherVC.selectedDate = dates[datePicker.selectedRow(inComponent: 0)]
            navigationController?.pushViewController(weatherVC, animated: true)
        } else {
            print("Failed to instantiate WeatherTableViewController")
        }
    }
    
    @IBAction func showImagesCollection(_ sender: UIButton) {
        if let collectionVC = storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController {
            navigationController?.pushViewController(collectionVC, animated: true)
        } else {
            print("Failed to instantiate CollectionViewController")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
}
