//
//  TableViewController.swift
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var weatherData: [[String: String]] = []
    var isCelsius = true // Track whether temperature is in Celsius
    var selectedDate: String? // Add this property to receive the selected date from ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // Print the selected date to verify it's passed correctly
        if let date = selectedDate {
            print("Selected date: \(date)")
        }
        
        // Load weather data from the Objective-C file
        loadWeatherData()
        
        // Add Refresh Button
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshData))
        navigationItem.rightBarButtonItem = refreshButton
        
        // Add Slider
        let slider = UISlider(frame: CGRect(x: 20, y: 80, width: 300, height: 40))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0 // Start with Celsius
        slider.addTarget(self, action: #selector(temperatureScaleChanged(_:)), for: .valueChanged)
        tableView.tableHeaderView = slider
    }

    // MARK: - Data Loading
    
    func loadWeatherData() {
        if let data = WeatherData().getWeatherData() as? [[String: String]] {
            weatherData = data
            tableView.reloadData()
        }
    }
    
    // MARK: - Button Action
    
    @objc func refreshData() {
        loadWeatherData()
        print("Weather data refreshed")
    }
    
    // MARK: - Slider Action
    
    @objc func temperatureScaleChanged(_ sender: UISlider) {
        isCelsius = sender.value < 0.5
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = weatherData[indexPath.section]

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
            cell.textLabel?.text = weather["city"]
            return cell

        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell", for: indexPath)
            if let temperature = weather["temperature"], let tempValue = Double(temperature) {
                let displayTemp = isCelsius ? tempValue : tempValue * 9 / 5 + 32
                let unit = isCelsius ? "°C" : "°F"
                cell.textLabel?.text = "Temperature: \(String(format: "%.1f", displayTemp))\(unit)"
            }
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            if let imageName = weather["image"] {
                cell.imageView?.image = UIImage(named: imageName)
            }
            cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            NSLayoutConstraint.activate([
                cell.imageView!.widthAnchor.constraint(equalToConstant: 100),
                cell.imageView!.heightAnchor.constraint(equalToConstant: 100),
                cell.imageView!.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                cell.imageView!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16)
            ])
            cell.imageView?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            cell.imageView?.addGestureRecognizer(tapGesture)
            cell.imageView?.tag = indexPath.section
            return cell
        }
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view else { return }
        
        // Create an alert controller
        let alertController = UIAlertController(
            title: "Image Alart",
            message: "This is Image",
            preferredStyle: .alert
        )
        
        // Add an OK action
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert
        if let viewController = sender.view?.window?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let selectedWeather = weatherData[indexPath.section]
            detailVC.cityName = selectedWeather["city"]
            detailVC.temperature = selectedWeather["temperature"]
            detailVC.weatherCondition = selectedWeather["condition"]
            detailVC.humidity = selectedWeather["humidity"]
            detailVC.weatherDescription = selectedWeather["description"]
            detailVC.weatherDate = selectedWeather["date"]
            
            if let imageName = selectedWeather["image"] {
                detailVC.cityImage = UIImage(named: imageName)
            }
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

