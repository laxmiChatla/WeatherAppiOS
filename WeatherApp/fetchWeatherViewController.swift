//
//  fetchWeatherViewController.swift
//  WeatherApp
//
//  Created by Laxmi Chandrashekhar Chatla on 29/06/24.
//

import UIKit

class fetchWeatherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var weatherTableView: UITableView!
    
    
    @IBOutlet var label_1: UILabel!
    
    
    @IBOutlet var label_2: UILabel!
    
    
    @IBOutlet var label_3: UILabel!
    
    
    @IBOutlet var last_updated: UILabel!
    
    
    @IBOutlet var country_name: UILabel!
    
    
    @IBOutlet var lat: UILabel!
    
    @IBOutlet var log: UILabel!
    
    
    @IBOutlet var temp_f: UILabel!
    
    @IBOutlet var temp_c: UILabel!
    
    
    
    @IBOutlet var select_country: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.dataSource=self
        weatherTableView.delegate=self
        print("selected_country",  Globals.selected_country)
        
        //fetchWeather(for: "India")
          fetchWeather(for: Globals.selected_country)
        
        let Tap=UITapGestureRecognizer()
        select_country.addGestureRecognizer(Tap)
        Tap.addTarget(self, action: #selector(ViewClicked))
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func ViewClicked(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "gotoBack", sender: self)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let watherdata=data[indexPath.row]
        
        if indexPath.row < data.count && indexPath.row >= 0 {
            let Ordersdata = data[indexPath.row]
            // Proceed with using Ordersdata
        } else {
            // Handle the out of range error
            print("Index out of range: \(indexPath.row)")
        }
        
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! WeatherTableViewCell
        
        print("Data array count: \(data.count)")
           print("Index path row: \(indexPath.row)")

        if indexPath.row < data.count{
            
            cell.name.text=watherdata.Name
            cell.value.text=watherdata.value_label
           
           
        }
        else{
            print("Index out of bounds: \(indexPath.row)")
        }
        
        
        return cell
        
        
    }
    
    struct weather_details{
        let Name:String
        let value_label:String
    }
    //cancelled-red-icon
    
    var data:[weather_details]=[]
    
    func fetchWeather(for country: String) {
            let apiKey = "d5d03b2aa8d94e6eb52135020242806"
            let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(country)&aqi=no"

            guard let url = URL(string: urlString) else { return }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.updateUI(with: weatherResponse)
                        
                    }
                } catch let decodingError {
                    print("Decoding Error: \(decodingError.localizedDescription)")
                }
            }

            task.resume()
        }

        func updateUI(with weatherResponse: WeatherResponse) {
            // Update your UI with the weather data
            print("Location: \(weatherResponse.location.name), \(weatherResponse.location.country)")
            print("Temperature: \(weatherResponse.current.temp_c)°C")
            print("Condition: \(weatherResponse.current.condition.text)")
            
            DispatchQueue.main.async {
                self.label_1.text=weatherResponse.location.name
                self.label_2.text=weatherResponse.location.region
                self.label_3.text=weatherResponse.location.country
                
                self.lat.text="lat: \(weatherResponse.location.lat)"
                 self.log.text="lon: \(weatherResponse.location.lon)"
                 
                self.temp_c.text="temp_c: \(weatherResponse.current.temp_c)"
                self.temp_f.text="temp_f: \(weatherResponse.current.temp_f)"
                
                self.country_name.text=weatherResponse.location.name
                self.last_updated.text="\(weatherResponse.current.last_updated)"
            }
            
            
         /*   DispatchQueue.main.async {
                self.label_1.text=weatherResponse.location.name
                self.label_2.text=weatherResponse.location.region
                self.label_3.text=weatherResponse.location.country
                
                
               /* self.lat.text="lat \(weatherResponse.location.lat)"
                self.log.text="lon \(weatherResponse.location.lon)"
                
                
                self.temp_c.text="temp_c \(weatherResponse.location.temp_c)"
                self.temp_f.text="temp_f \(weatherResponse.location.temp_f)"
                
                self.country_name.text=weatherResponse.location.name
                self.last_updated.text="\(weatherResponse.current.last_updated)"*/
                
                
            }*/
            
            
            
        
            self.data.append(
                weather_details(Name: "wind_kph", value_label: "\(weatherResponse.current.wind_kph)"))
            
            self.data.append(
                weather_details(Name: "wind_degree", value_label: "\(weatherResponse.current.wind_degree)"))
            
            
            self.data.append(
                weather_details(Name: "wind_dir", value_label: "\(weatherResponse.current.wind_dir)"))
            
            
            self.data.append(
                weather_details(Name: "pressure_mb", value_label: "\(weatherResponse.current.pressure_mb)"))
            
            self.data.append(
                weather_details(Name: "humidity", value_label: "\(weatherResponse.current.humidity)"))
            
            
            self.data.append(
                weather_details(Name: "cloud", value_label: "\(weatherResponse.current.cloud)"))
            
            
            self.data.append(
                weather_details(Name: "feelslike_c", value_label: "\(weatherResponse.current.feelslike_c)"))
            
            self.data.append(
                weather_details(Name: "vis_km", value_label: "\(weatherResponse.current.vis_km)"))
            
            
            self.data.append(
                weather_details(Name: "uv", value_label: "\(weatherResponse.current.uv)"))
            
            self.data.append(
                weather_details(Name: "gust_kph", value_label: "\(weatherResponse.current.gust_kph)"))
            
            weatherTableView.reloadData()
    
            
        }
    

}
