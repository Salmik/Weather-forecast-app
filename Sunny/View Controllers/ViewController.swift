import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    // add your own api key from https://openweathermap.org/api
    private let apiKey = ""
    var networkManager = NetworkService()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter the city Name", message: "you can enter the city in name in textFiled", style: .alert) { [weak self] (cityName) in
            guard let self = self else { return }
            self.networkManager.fetchData(city: cityName, apiKey: self.apiKey) { weather in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.updateUI(currentWeather: weather)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // networkManager.delegate = self
    }
    
    func updateUI(currentWeather: CurrentWeather) {
        cityLabel.text = currentWeather.cityName
        temperatureLabel.text = currentWeather.temperatureString
        feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
        weatherIconImageView.image = UIImage(systemName: currentWeather.systemIconNameString)
    }
    
}

//extension ViewController: NetworkServiceDelegate {
//    func updateInterface(_: NetworkService, currentWeather: CurrentWeather) {
//        print(currentWeather.cityName)
//    }
//}
