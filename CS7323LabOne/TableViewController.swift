

//
//  WeatherViewController.swift
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    var weatherData: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120 // Set estimated height based on the larger image size
        // 从 Objective-C 文件获取天气数据
        if let data = WeatherData().getWeatherData() as? [[String: String]] {
            weatherData = data
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Each section contains only one row showing city name and image
        return 3
    }

    // Configure each cell based on its type
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = weatherData[indexPath.section] // Get weather data for the current section

        if indexPath.row == 0 {
            // City cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
            cell.textLabel?.text = weather["city"] // Assuming city name is in the dictionary
            return cell

        } else if indexPath.row == 1 {
            // Temperature cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemperatureCell", for: indexPath)
            if let temperature = weather["temperature"] {
                cell.textLabel?.text = "Temperature: \(temperature)°C"
            }
            return cell

        }else {
            // Image cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
            
            // Set the image based on the weather condition
            if let imageName = weather["image"] {
                cell.imageView?.image = UIImage(named: imageName)
            }
            
            // Adjust the image size by setting the image view constraints
            cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            
            // Set constraints to enlarge the image view
            NSLayoutConstraint.activate([
                cell.imageView!.widthAnchor.constraint(equalToConstant: 100), // Set desired width
                cell.imageView!.heightAnchor.constraint(equalToConstant: 100), // Set desired height
                cell.imageView!.centerYAnchor.constraint(equalTo: cell.centerYAnchor), // Center vertically
                cell.imageView!.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16) // Set leading space
            ])
            
            // Enable user interaction on the image view and add tap gesture
            cell.imageView?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            cell.imageView?.addGestureRecognizer(tapGesture)
            cell.imageView?.tag = indexPath.section // Tag to identify the specific section
            
            return cell
        }

    }

    // Function to handle image tap events
        @objc func imageTapped(_ sender: UITapGestureRecognizer) {
            guard let tappedImageView = sender.view else { return }
            let section = tappedImageView.tag
            // Handle the tap event, e.g., display more details about the image related to the section
            print("Image tapped in section: \(section)")
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Create an instance of the DetailViewController from the storyboard
            if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                
                // Get the selected weather data
                let selectedWeather = weatherData[indexPath.section]
                
                // Pass the data to the DetailViewController
                detailVC.cityName = selectedWeather["city"]
                detailVC.temperature = selectedWeather["temperature"]
                detailVC.weatherCondition = selectedWeather["condition"]
                detailVC.humidity = selectedWeather["humidity"]
                detailVC.weatherDescription = selectedWeather["description"]
                
                if let imageName = selectedWeather["image"] {
                    detailVC.cityImage = UIImage(named: imageName)
                }
                
                // Push the DetailViewController to the navigation stack
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
