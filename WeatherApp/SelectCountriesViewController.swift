//
//  SelectCountriesViewController.swift
//  WeatherApp
//
//  Created by Laxmi Chandrashekhar Chatla on 29/06/24.
//

import UIKit
import iOSDropDown
class SelectCountriesViewController: UIViewController,UITextFieldDelegate {
    
        @IBOutlet weak var countryDropDown: DropDown!

    let allCountries = [
           "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda",
           "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain",
           "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan",
           "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria",
           "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia", "Cameroon", "Canada",
           "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros",
           "Congo, Democratic Republic of the", "Congo, Republic of the", "Costa Rica",
           "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica",
           "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea",
           "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon",
           "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea",
           "Guinea-Bissau", "Guyana", "Haiti", "Honduras", "Hungary", "Iceland", "India",
           "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan",
           "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, North", "Korea, South", "Kosovo",
           "Kuwait", "Kyrgyzstan", "Laos", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya",
           "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi", "Malaysia",
           "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico",
           "Micronesia", "Moldova", "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique",
           "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "New Zealand", "Nicaragua",
           "Niger", "Nigeria", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau",
           "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland",
           "Portugal", "Qatar", "Romania", "Russia", "Rwanda", "Saint Kitts and Nevis",
           "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
           "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Serbia", "Seychelles",
           "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia",
           "South Africa", "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden",
           "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Timor-Leste",
           "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan",
           "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States",
           "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela", "Vietnam", "Yemen",
           "Zambia", "Zimbabwe"
       ]

       override func viewDidLoad() {
           super.viewDidLoad()
           setupDropDown()
           countryDropDown.delegate = self
           countryDropDown.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
       }

       func setupDropDown() {
           countryDropDown.optionArray = allCountries // Initially, all countries
           countryDropDown.didSelect { (selectedText, index, id) in
               print("Selected country: \(selectedText) at index: \(index)")
               
               Globals.selected_country=selectedText
               
               print("selected_country",  Globals.selected_country)
           }
       }

       @objc func textFieldDidChange(_ textField: UITextField) {
           guard let searchText = textField.text else { return }
           if searchText.count == 3 {
               filterCountries(with: searchText)
           } else if searchText.isEmpty {
               countryDropDown.optionArray = allCountries
           }
       }

       func filterCountries(with searchText: String) {
           let filteredCountries = allCountries.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
           countryDropDown.optionArray = filteredCountries
           countryDropDown.showList()
       }
    
    
    @IBAction func nextaction(_ sender: Any) {
        
        
        
        if countryDropDown.text!.isEmpty{
            displayAlert(alertMessage: "Please Select the Country", alertTitle: "Alert")
        }
        else{
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "gotohome", sender: self)
            }
        }
        
        
    }
    
    
    func displayAlert(alertMessage:String,alertTitle:String){
        DispatchQueue.main.async {
            let uialert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
                  uialert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
               self.present(uialert, animated: true, completion: nil)
        }
    }
    
    
   }
