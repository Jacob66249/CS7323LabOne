//
//  DetailViewController.swift
//  CS7323LabOne
//
//  Created by Zhiwei Cheng on 9/18/24.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var cityName: String?
    var temperature: String?
    var cityImage: UIImage?
    var weatherCondition: String?
    var humidity: String?
    var weatherDescription: String?
    var weatherDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    private func setupUI() {
        // Initialize labels with data
        cityLabel.text = "City: \(cityName ?? "N/A")"
        temperatureLabel.text = "Temperature: \(temperature ?? "N/A")"
        conditionLabel.text = "Condition: \(weatherCondition ?? "Unknown")"
        cityImageView.image = cityImage
        humidityLabel.text = "Humidity: \(humidity ?? "N/A")"
        descriptionLabel.text = "Description: \(weatherDescription ?? "No description available")"
        
        // Allow descriptionLabel to expand based on content
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.sizeToFit()

        // ScrollView setup
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        // Update content size to ensure all content is visible
        updateScrollViewContentSize()

        // Stepper setup
        stepper.minimumValue = 5
        stepper.maximumValue = 15
        stepper.value = 10
        stepperLabel.text = "Font Size: \(Int(stepper.value))"
        updateFontSize(size: CGFloat(stepper.value))

        // Segmented Control initial state
        segmentedControl.selectedSegmentIndex = 0
    }

    private func updateScrollViewContentSize() {
        // Update scroll view content size based on subviews' content
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }


    private func setupActions() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)

        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
    }

    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        let isShowingDateOnly = sender.selectedSegmentIndex == 1
        if isShowingDateOnly {
            // Display date prominently in the cityLabel
            cityLabel.text = "Date:  \(weatherDate ?? "N/A")"
        
        } else {
            cityLabel.text = "City: \(cityName ?? "N/A")"
        }
        
        // Hide or show other labels based on the selected segment
        let shouldHide = isShowingDateOnly
        [temperatureLabel, conditionLabel, humidityLabel, descriptionLabel, cityImageView, stepper, stepperLabel].forEach { $0?.isHidden = shouldHide }
    }


    @objc private func stepperValueChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        updateFontSize(size: fontSize)
        stepperLabel.text = "Font Size: \(Int(fontSize))"
    }

    private func updateFontSize(size: CGFloat) {
        let labels = [cityLabel, temperatureLabel, conditionLabel, humidityLabel, descriptionLabel, stepperLabel]
        labels.forEach { $0?.font = UIFont.systemFont(ofSize: size) }
    }

    @objc private func switchValueChanged(_ sender: UISwitch) {
        let isHidden = !sender.isOn
        [cityLabel, temperatureLabel, conditionLabel, humidityLabel, descriptionLabel, cityImageView, stepper, stepperLabel].forEach { $0?.isHidden = isHidden }
    }

    @objc private func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        let newZoomScale = scrollView.zoomScale == scrollView.minimumZoomScale ? scrollView.maximumZoomScale : scrollView.minimumZoomScale
        scrollView.setZoomScale(newZoomScale, animated: true)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cityImageView
    }
}
