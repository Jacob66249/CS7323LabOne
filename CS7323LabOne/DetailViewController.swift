import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView! // Connected in storyboard
    @IBOutlet weak var humidityLabel: UILabel! // Connected in storyboard
    @IBOutlet weak var descriptionLabel: UILabel! // Connected in storyboard
    @IBOutlet weak var stepper: UIStepper! // Connect this to the stepper in storyboard
    @IBOutlet weak var toggleSwitch: UISwitch! // Connect this to the switch in storyboard
    @IBOutlet weak var stepperLabel: UILabel!
    
    var cityName: String?
    var temperature: String?
    var cityImage: UIImage?
    var weatherCondition: String?
    var humidity: String?
    var weatherDescription: String? // Ensure this is not nil or empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up labels and image
        cityLabel.text = "City: \(cityName ?? "N/A")"
        temperatureLabel.text = "Temperature: \(temperature ?? "N/A")"
        conditionLabel.text = "Condition: \(weatherCondition ?? "Unknown")"
        cityImageView.image = cityImage
        humidityLabel.text = "Humidity: \(humidity ?? "N/A")"
        
        // Debug: Check what text is being assigned
        let fullDescription = "Description: \(weatherDescription ?? "No description available")"
        print("Full Description: \(fullDescription)") // Check console output
        
        // Set up the descriptionLabel with multiple lines and wrapping
        descriptionLabel.text = fullDescription
        descriptionLabel.numberOfLines = 0 // Allows unlimited lines
        descriptionLabel.lineBreakMode = .byWordWrapping // Wraps text to the next line
        
        // Force the label to adjust size to fit content
        descriptionLabel.sizeToFit()
        
        // Set up the scroll view for zooming (if used for zoom purposes)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.contentSize = cityImageView.bounds.size
        
        // Add gesture recognizer for double-tap zooming
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(recognizer:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
        
        // Setting up stepper
        stepper.minimumValue = 5
        stepper.maximumValue = 15
        stepper.value = 10
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        // Setting up switch
        toggleSwitch.isOn = false
        toggleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        // Optional: Label for stepper value
        stepperLabel.text = "Font Size: \(Int(stepper.value))"
        
        // Initialize font size
        updateFontSize(size: CGFloat(stepper.value))
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        // Adjust the font size of the labels based on the stepper value
        let fontSize = CGFloat(sender.value)
        updateFontSize(size: fontSize)
        stepperLabel.text = "Font Size: \(Int(fontSize))"
        print("Stepper value changed to: \(sender.value)")
    }
    
    // Helper method to update font size of all relevant labels
    private func updateFontSize(size: CGFloat) {
        cityLabel.font = UIFont.systemFont(ofSize: size)
        temperatureLabel.font = UIFont.systemFont(ofSize: size)
        conditionLabel.font = UIFont.systemFont(ofSize: size)
        humidityLabel.font = UIFont.systemFont(ofSize: size)
        descriptionLabel.font = UIFont.systemFont(ofSize: size)
        stepperLabel.font = UIFont.systemFont(ofSize: size)
    }
    
    // Action for Switch
    @objc func switchValueChanged(_ sender: UISwitch) {
        // Control whether to display all data
        let isHidden = !sender.isOn
        cityLabel.isHidden = isHidden
        temperatureLabel.isHidden = isHidden
        conditionLabel.isHidden = isHidden
        humidityLabel.isHidden = isHidden
        descriptionLabel.isHidden = isHidden
        cityImageView.isHidden = isHidden
        stepper.isHidden = isHidden
        stepperLabel.isHidden = isHidden
        
        if sender.isOn {
            print("All data display turned ON")
        } else {
            print("All data display turned OFF")
        }
    }
    
    // Method to handle the double-tap gesture
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    // Delegate method to specify the view for zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cityImageView
    }
}
