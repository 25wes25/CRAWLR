//
//  SearchViewController.swift
//  CRAWLR
//
//  Created by Rachel Bright on 4/22/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate,  CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var barsButton: UIButton!
    @IBOutlet weak var barsLabel: UILabel!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var foodLabel: UILabel!
    
    var businesses: [Business]?
    var realBusinesses: [Business]?
    var category = "bars"
    let locationManager = CLLocationManager()
    var longitude: Double?
    var latitude: Double?
    var searchText: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
            
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        longitude = locValue.longitude
        latitude = locValue.latitude
        
        getBusinesses()
        
    }
    
    func getBusinesses () {
        let onDidRecieveBusinesses: ([Business]?) -> Void = { businesses in
            if let businesses = businesses {
                self.businesses = businesses
                self.realBusinesses = businesses
                self.collectionView.reloadData()
            }
        }
        
        if let longitude = self.longitude {
            if let latitude = self.latitude {
                if let searchText = self.searchText{
                    if !searchText.isEmpty{
                        ApiHelper.instance.getBusinesses(text: searchText, latitude: latitude, longitude: longitude, categories: self.category, callback: onDidRecieveBusinesses)
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showInfo", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.businesses?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        
        if let imageUrlString = self.businesses?[indexPath.item].image_url {
            if let imageUrl = URL(string: imageUrlString){
                if let imageData = try? Data(contentsOf: imageUrl){
                    searchCell.picture.image = UIImage(data: imageData)
                }
            }
        }
        
        searchCell.name.text = self.businesses?[indexPath.item].name
        searchCell.name.isHidden = false

        if let distanceMeters = self.businesses?[indexPath.item].distance {
            let distanceMiles = distanceMeters * 0.000621371
            searchCell.distance.text = String(format: "%.2f", distanceMiles) + " miles away"
            searchCell.distance.isHidden = false
        }
        
        let address = self.businesses?[indexPath.item].location
        let addressString1 = address?.address1 ?? ""
        let addressString2 = address?.city ?? ""
        searchCell.address.text = addressString1 + ", " + addressString2
        searchCell.address.isHidden = false
        
        return searchCell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            self.searchText = searchText
            self.getBusinesses()
        } else {
            self.businesses?.removeAll()
        }
        self.collectionView.reloadData()
    }
    
    @IBAction func whenBarButtonPressed(_ sender: Any) {
        self.category = "bars"
        foodLabel.textColor = UIColor.white
        barsLabel.textColor = UIColor.systemTeal
       
    }
    
    @IBAction func whenFoodButtonPressed(_ sender: Any) {
        self.category = "food"
        barsLabel.textColor = UIColor.white
        foodLabel.textColor = UIColor.systemTeal
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedBusinessInfoViewController {
             if let index = collectionView.indexPathsForSelectedItems?.first {
                destination.selectedBusinessID = businesses?[index.row].id
                destination.selectedBusinessDistance = businesses?[index.row].distance
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


