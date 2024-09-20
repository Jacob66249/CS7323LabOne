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
    @IBOutlet weak var segmentedControl: UISegmentedControl! // Connect to the segmented control in storyboard

    var cityName: String?
    var temperature: String?
    var cityImage: UIImage?
    var weatherCondition: String?
    var humidity: String?
    var weatherDescription: String?
    var weatherDate: String? = "Date: September 19, 2024" // Example date data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up labels and image
        cityLabel.text = "City: \(cityName ?? "N/A")"
        temperatureLabel.text = "Temperature: \(temperature ?? "N/A")"
        conditionLabel.text = "Condition: \(weatherCondition ?? "Unknown")"
        cityImageView.image = cityImage
        humidityLabel.text = "Humidity: \(humidity ?? "N/A")"
        
        let fullDescription = "Description: \(weatherDescription ?? "No description available")"
        descriptionLabel.text = fullDescription
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.sizeToFit()
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.contentSize = cityImageView.bounds.size
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        stepper.minimumValue = 5
        stepper.maximumValue = 15
        stepper.value = 10
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        toggleSwitch.isOn = false
        toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        stepperLabel.text = "Font Size: \(Int(stepper.value))"
        updateFontSize(size: CGFloat(stepper.value))
        
        // Setup for segmented control
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // Show weather data
            cityLabel.isHidden = false
            temperatureLabel.isHidden = false
            conditionLabel.isHidden = false
            humidityLabel.isHidden = false
            descriptionLabel.isHidden = false
            cityImageView.isHidden = false
            stepper.isHidden = false
            stepperLabel.isHidden = false
        case 1: // Show date information
            cityLabel.text = weatherDate // Show date information in the city label as an example
            temperatureLabel.isHidden = true
            conditionLabel.isHidden = true
            humidityLabel.isHidden = true
            descriptionLabel.isHidden = true
            cityImageView.isHidden = true
            stepper.isHidden = true
            stepperLabel.isHidden = true
        default:
            break
        }
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        updateFontSize(size: fontSize)
        stepperLabel.text = "Font Size: \(Int(fontSize))"
    }
    
    private func updateFontSize(size: CGFloat) {
        cityLabel.font = UIFont.systemFont(ofSize: size)
        temperatureLabel.font = UIFont.systemFont(ofSize: size)
        conditionLabel.font = UIFont.systemFont(ofSize: size)
        humidityLabel.font = UIFont.systemFont(ofSize: size)
        descriptionLabel.font = UIFont.systemFont(ofSize: size)
        stepperLabel.font = UIFont.systemFont(ofSize: size)
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        let isHidden = !sender.isOn
        cityLabel.isHidden = isHidden
        temperatureLabel.isHidden = isHidden
        conditionLabel.isHidden = isHidden
        humidityLabel.isHidden = isHidden
        descriptionLabel.isHidden = isHidden
        cityImageView.isHidden = isHidden
        stepper.isHidden = isHidden
        stepperLabel.isHidden = isHidden
    }
    
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cityImageView
    }
}
