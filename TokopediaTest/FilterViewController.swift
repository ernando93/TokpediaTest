//
//  FilterViewController.swift
//  TokopediaTest
//
//  Created by Ernando on 9/7/18.
//  Copyright © 2018 HappyCoding. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol requestFilterDelegate {
    func getRequestFilter(withMinPrice minPrice: String, withMaxPrice maxPrice: String, withWholeSale wholeSale: Bool, withOfficial official: Bool, withFShop fShop: String, withStart start: String, andRows rows: String)
}

class FilterViewController: UIViewController {

    var delegate: requestFilterDelegate?
    
    @IBOutlet weak var labelTitleMinPrice: UILabel!
    @IBOutlet weak var labelTitleMaxPrice: UILabel!
    @IBOutlet weak var labelMinPrice: UILabel!
    @IBOutlet weak var labelMaxPrice: UILabel!
    @IBOutlet weak var slider:RangeSeekSlider!
    @IBOutlet weak var switchWholeSale: UISwitch!
    @IBOutlet weak var buttonGoldMerChant: UIButton!
    @IBOutlet weak var buttonOfficialStore: UIButton!
    
    var minPrice: Int = 10000
    var maxPrice: Int = 100000
    var wholeSale: Bool = false
    var buttonGoldTap: Bool = false
    var buttonOfficialTap: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSliderPrice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: SetupView
extension FilterViewController {
    func setupView() {
        setupLabel()
        setupButton()
    }
    
    func setupLabel() {
        setupLabelPrice(withMinPrice: "10.000", andMaxPrice: "100.000")
    }
    
    func setupLabelPrice(withMinPrice minPrice: String, andMaxPrice maxPrice: String) {
        labelMinPrice.text = "Rp " + minPrice
        labelMaxPrice.text = "Rp " + maxPrice
    }
    
    func setupButton() {
        setupButtonStyle(withButton: buttonGoldMerChant)
        setupButtonStyle(withButton: buttonOfficialStore)
    }
    
    func setupButtonStyle(withButton button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15.0
    }
}

//MARK: Setup Slider Price
extension FilterViewController: RangeSeekSliderDelegate {
    func setupSliderPrice() {
        slider.delegate = self
        slider.minValue = 10000
        slider.selectedMinValue = 10000
        slider.maxValue = 100000
        slider.selectedMaxValue = 100000
        slider.hideLabels = true
        slider.enableStep = true
        slider.step = 1000
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minPrice = Int(minValue)
        maxPrice = Int(maxValue)
        
        let newMinPrice = formatCurrency(price: "\(minPrice)", digitBeforeZero: 0)
        let newMaxPrice = formatCurrency(price: "\(maxPrice)", digitBeforeZero: 0)
        
        setupLabelPrice(withMinPrice: "\(newMinPrice)", andMaxPrice: "\(newMaxPrice)")
        
    }
    
}

//MARK: Action
extension FilterViewController {
    @IBAction func buttonBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonReset(_ sender: UIButton) {
        slider.maxValue = 100000
        slider.selectedMaxValue = 100000
        setupSliderPrice()
        setupLabel()
        switchWholeSale.isOn = false
        buttonGoldMerChant.backgroundColor = UIColor.white
        buttonGoldTap = false
        buttonOfficialStore.backgroundColor = UIColor.white
        buttonOfficialTap = false
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if sender.isOn == true {
            wholeSale = true
        } else {
            wholeSale = false
        }
    }
    
    @IBAction func buttonGoldTapped(_ sender: UIButton) {
        if buttonGoldTap == false {
            buttonGoldTap = true
            buttonGoldMerChant.backgroundColor = UIColor.green.withAlphaComponent(0.15)
        } else {
            buttonGoldTap = false
            buttonGoldMerChant.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func buttonOfficialTapped(_ sender: UIButton) {
        if buttonOfficialTap == false {
            buttonOfficialTap = true
            buttonOfficialStore.backgroundColor = UIColor.green.withAlphaComponent(0.15)
        } else {
            buttonOfficialTap = false
            buttonOfficialStore.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func buttonApply(_ sender: UIButton) {
        self.dismiss(animated: false, completion: {
            self.delegate?.getRequestFilter(withMinPrice: "\(self.minPrice)", withMaxPrice: "\(self.maxPrice)", withWholeSale: self.wholeSale, withOfficial: self.buttonOfficialTap, withFShop: "2", withStart: "0", andRows: "25")
        })
    
    }
    
    func formatCurrency(price: String, digitBeforeZero: Int) -> String {
        if price == "" {
            return String()
        }
        
        let newPrice = price.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let value: Double = Double(newPrice)!
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.minimumFractionDigits = digitBeforeZero
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        let svalue = formatter.string(from: value as NSNumber)
        return svalue!
    }
}
