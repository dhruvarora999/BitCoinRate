//
//  ViewController.swift
//  Bitcoin Ticker
//
//  Created by SSDN2 on 07/03/19.
//  Copyright © 2019 dhruv. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController ,UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    var pickerData: [String] = [String]()
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedText = pickerData[row]
        let params : [String : String] = ["function" : "CURRENCY_EXCHANGE_RATE" , "from_currency" : "BTC" , "to_currency" : selectedText , "apikey" : APPID ]
        getCurrencyData(url: url, parameters: params)
       
    }
     var selectedText : String = " "
 
    var url : String = "https://www.alphavantage.co/query"
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    let APPID : String = "ND4GPLY1LI3N5UF3"
    

    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.currencyPicker.dataSource = self
        self.currencyPicker.delegate = self
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
        pickerData = ["AED",
                      "AFN",
                      "ALL",
                      "AMD",
                      "ANG",
                      "AOA",
                      "ARS",
                      "AUD",
                      "BDT",
                      "CAD",
                      "EUR",
                      "FJD",
                      "GBP",
                      "HKD",
                      "HUF",
                      "IDR",
                      "ILS",
                      "INR",
                      "IQD",
                      "IRR",
                  
                      "JPY",
                    
                      "KPW",
                      "KRW",
                      "KWD",
                    
                      "LKR",
                      "MUR",
                      "NPR",
                      "NZD",
                      "PHP",
                      "PKR",
                      "PYG",
                      "QAR",
                      "RON",
                      "RSD",
                      "RUB",
                      "SAR",
                      "SEK",
                      "SGD",
                      "THB",
                      "TJS",
                      "TMT",
                      "TND:",
                      "TOP",
                      "TRY",
                      "USD"]
       
        currencyPicker.selectRow( 17, inComponent: 0, animated: true)
        
    }

    func getCurrencyData(url: String, parameters: [String: String]) {

        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {

                print("Success! Got the currency data")
                let currencyJSON : JSON = JSON(response.result.value!)


           
             print(currencyJSON)
                
               
               
                self.updateCurrencyData(json: currencyJSON)
              

            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.exchangeRateLabel.text = "Connection Issues"
            }
        }

    }
    func updateCurrencyData(json : JSON) {
        
        let currencyRate : String = json["Realtime Currency Exchange Rate"]["5. Exchange Rate"].stringValue
        
        exchangeRateLabel.text = String(currencyRate)
    }

}

