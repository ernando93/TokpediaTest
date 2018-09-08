//
//  ViewController.swift
//  TokopediaTest
//
//  Created by Ernando on 9/7/18.
//  Copyright © 2018 HappyCoding. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var modelData: ModelData?
    var dataModel: [DataModel] = []
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shop List"
        
        requestData(withMinPrice: "10000", withMaxPrice: "100000", withWholeSale: true, withOfficial: true, withFShop: "2", withStart: "0", andRows: "100")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.backgroundView = UIView.init(frame: CGRect.zero)
        
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Request
extension ViewController {
    func requestData(withMinPrice minPrice: String, withMaxPrice maxPrice: String, withWholeSale wholeSale: Bool, withOfficial official: Bool, withFShop fShop: String, withStart start: String, andRows rows: String) {
        let url = "https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=\(minPrice)&pmax=\(maxPrice)&wholesale=\(wholeSale)&official=\(official)&fshop=\(fShop)&start=\(start)&rows=\(rows)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch response.result {
                
            case .success(let responseBanner):
                print(responseBanner)
                if let responseValue = ModelData(dictionary: (responseBanner as? [String: Any])!) {
                    self.modelData = responseValue
                    self.dataModel = responseValue.dataModel
                    print(self.dataModel)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
}

//MARK: Setup CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 0, 10, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2 - 5, height: 237.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCollectionViewCell {
            
            let data = dataModel[indexPath.row]
            
            cell.cellConfigure(withData: data)
            
            return cell
        } else {
            return ListCollectionViewCell()
        }
    }
    
    
}

//MARK: Action
extension ViewController {
    @IBAction func buttonFillter(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FilterPage") as! FilterViewController
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

//MARK: Filter Delegate
extension ViewController: requestFilterDelegate {
    func getRequestFilter(withMinPrice minPrice: String, withMaxPrice maxPrice: String, withWholeSale wholeSale: Bool, withOfficial official: Bool, withFShop fShop: String, withStart start: String, andRows rows: String) {
        
        requestData(withMinPrice: minPrice, withMaxPrice: maxPrice, withWholeSale: wholeSale, withOfficial: official, withFShop: fShop, withStart: start, andRows: rows)
    }
    
    
}
