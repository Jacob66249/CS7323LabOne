//
//  WeatherViewController.swift
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/18/24.
//

import UIKit

class WeathertTableViewController: UITableViewController {
    var weatherData = WeatherData().getWeatherData() as! [[String: Any]]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        // Register 3 different cell types
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Type1")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Type2")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Type3")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = weatherData[indexPath.row]
        let cell: UITableViewCell

        switch indexPath.row % 3 {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "Type1", for: indexPath)
            cell.textLabel?.text = data["city"] as? String
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Type2", for: indexPath)
            cell.textLabel?.text = "Temperature: \(data["temperature"]!)°F"
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "Type3", for: indexPath)
            cell.textLabel?.text = data["condition"] as? String
        }

        return cell
    }
}


