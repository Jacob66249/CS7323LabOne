//
//  ViewController.swift
//  CS7323LabOne
//
//  Created by Zhiwei Cheng on 9/18/24.
//

import UIKit
//
//  ViewController.swift
//  CS7323LabOne
//
//  Created by Zhiwei Cheng on 9/18/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var datePicker: UIPickerView! // Connect your UIPickerView from storyboard
    @IBOutlet weak var timerLabel: UILabel! // Label to display timer updates (add this UILabel in your storyboard)
    
    // Array to hold date values
    var dates: [String] = []
    
    // Timer variable
    var timer: Timer?
    var counter: Int = 0 // Example counter to demonstrate the timer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the picker view with delegate and data source
        datePicker.delegate = self
        datePicker.dataSource = self
        
        // Populate the dates array (e.g., last 7 days)
        populateDates()
        
        // Start the timer
        startTimer()
    }
    
    // Populate the dates array with the last 7 days (you can modify this as needed)
    func populateDates() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        for dayOffset in 0...6 {
            if let date = Calendar.current.date(byAdding: .day, value: -dayOffset, to: Date()) {
                dates.append(formatter.string(from: date))
            }
        }
    }
    
    // Start the timer to update the label every second
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }
    
    // Method to update the view periodically
    @objc func updateView() {
        counter += 1
        timerLabel.text = "Timer: \(counter) seconds"
        
        // Add any other UIView updates you need here
    }
    
    // UIPickerViewDataSource - Number of components (columns) in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewDataSource - Number of rows in the component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    // UIPickerViewDelegate - Title for each row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dates[row]
    }
    
    // Action to show the WeatherTableViewController
    @IBAction func showWeatherTable(_ sender: UIButton) {
        // Get the selected date
        let selectedRow = datePicker.selectedRow(inComponent: 0)
        let selectedDate = dates[selectedRow]
        
        // Instantiate WeatherTableViewController from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let weatherVC = storyboard.instantiateViewController(withIdentifier: "WeatherTableViewController") as? WeatherTableViewController {
            // Pass the selected date to WeatherTableViewController
            weatherVC.selectedDate = selectedDate
            navigationController?.pushViewController(weatherVC, animated: true)
        } else {
            print("Failed to instantiate WeatherTableViewController")
        }
    }
    
    // Action to show the CollectionViewController
    @IBAction func showImagesCollection(_ sender: UIButton) {
        // Instantiate CollectionViewController from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let collectionVC = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController {
            // Push the CollectionViewController onto the navigation stack
            navigationController?.pushViewController(collectionVC, animated: true)
        } else {
            print("Failed to instantiate CollectionViewController")
        }
    }
    
    // Stop the timer when the view is about to disappear to prevent memory leaks
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
