//
//  TableViewCell.swift
//  AmazonUiProject
//
//  Created by Vijay Lal on 25/08/24.
//

import Foundation
import UIKit
class TableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var amazonPayStackView: UIStackView!
    @IBOutlet weak var textFild: UITextField!
    @IBOutlet weak var addSliderPoster: UICollectionView!
    var sliderImageArray = ["lap1", "lap3", "lap2"]
    override func awakeFromNib() {
        addSliderPoster.isPagingEnabled = true
        addSliderPoster.translatesAutoresizingMaskIntoConstraints = false
        [addSliderPoster.widthAnchor.constraint(equalTo: self.widthAnchor),
         addSliderPoster.heightAnchor.constraint(equalToConstant: 156),
         addSliderPoster.topAnchor.constraint(equalTo: amazonPayStackView.bottomAnchor, constant: 20),
         addSliderPoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        ].forEach({ $0.isActive = true })
        addSliderPoster.delegate = self
        addSliderPoster.dataSource = self
    }
}
extension TableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.imageSlider.image = UIImage(named: sliderImageArray[indexPath.row])
        cell.imageSlider.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hello")
    }
}
