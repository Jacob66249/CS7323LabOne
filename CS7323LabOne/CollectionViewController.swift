//
//  CollectionViewController.swift
//  CS7323LabOne
//
//  Created by mingyun zhang on 9/19/24.
//


import UIKit

private let reuseIdentifier = "CollectCell"

// Define the custom protocol outside of the classes
protocol ImageDisplayable: AnyObject {
    func displayImage(_ image: UIImage)
}

class CollectionViewController: UICollectionViewController {

    // Use WeatherData singleton to access weather data and images
    lazy var weatherData = {
        return WeatherData.sharedInstance()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes if not using storyboard prototype cells
        // self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Get the number of images from the WeatherData
        return self.weatherData?.numberOfImages() ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue the cell and set the image
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let image = self.weatherData?.getImageAt(indexPath.row)
        cell.imageView.image = image
        return cell
    }

    // Handle item selection to display the image
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedImage = self.weatherData?.getImageAt(indexPath.row) {
            // Initialize ImagePopupViewController
            let imagePopupVC = ImagePopupViewController()
            
            // Set the selected image and display it using the protocol method
            imagePopupVC.selectedImage = selectedImage
            self.present(imagePopupVC, animated: true, completion: nil)
        }
    }
}

// Implementation of ImagePopupViewController
class ImagePopupViewController: UIViewController, ImageDisplayable {

    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        // Set up the gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)

        // Set up the image view
        guard let image = selectedImage else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)

        // Add gesture recognizer to close the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        imageView.addGestureRecognizer(tapGesture)

        // Optional: Add swipe down gesture to close
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }

    // Method to dismiss the view controller
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    // Implement the protocol method to display the image
    func displayImage(_ image: UIImage) {
        self.selectedImage = image
        self.modalPresentationStyle = .fullScreen
        self.present(self, animated: true, completion: nil)
    }
}



    
    // MARK: - UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

