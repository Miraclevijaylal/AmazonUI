//
//  ProductListTableCell.swift
//  AmazonUiProject
//
//  Created by Vijay Lal on 25/08/24.
//

import Foundation
import UIKit
class ProductListTableCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var productList: UICollectionView!
    var net = Networking()
    var model: ProductModel?
    var productImages = ["one", "six", "five", "two","tshirt3", "tshirt2", "tshirt1", "mug", "bodylotion", "faceWash"]
    var brandNames = ["Skechers", "Buggati", "G-Shock", "Puma", "SuperDry", "Zudio", "Zudio", "Starbucks", "Vasline", "Lotus"]
    var productPrice = ["$800", "$300000", "$15000", "$600", "$150", "$20", "$20", "$25", "$15", "18$"]
    var productDetail = ["Mens Shoes", "Luxury Watch", "5Series Watch", "Mens Shoes", "Mens tShirt", "Mens tShirt", "Mens tShirt", "Mug", "Body Lotion", "FaceWash"]
    override func awakeFromNib() {
        displayData()
        productList.dataSource = self
        productList.delegate = self
    }
    func displayData() {
        net.getAllproduct(url: "https://dummyjson.com/products") { successData, isSuccess in
            if isSuccess {
                if let products = successData {
                    do {
                        self.model = try JSONDecoder().decode(ProductModel.self, from: products)
                        DispatchQueue.main.async { [self] in
                            productList.dataSource = self
                            productList.delegate = self
                            productList.reloadData()
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
    }
}
extension ProductListTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        if let url = URL(string:"\(model?.products[indexPath.row].thumbnail ?? "")") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { imageData, _, _ in
                DispatchQueue.main.async {
                    cell.imageproducts.image = UIImage(data: imageData!)
                }
            }.resume()
        }
//        cell.imageproducts
//        cell.brandName.text = brandNames[indexPath.row]
//        cell.productPrice.text = productPrice[indexPath.row]
//        cell.productDetail.text = productDetail[indexPath.row]
        cell.layer.cornerRadius = 16
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (collectionView.frame.width) / 2
        return CGSize(width: w - 15 , height: 230)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
    }
//    func getContentHeight() -> CGFloat {
//        return productList.collectionViewLayout.collectionViewContentSize.height
//    }
}
