import Foundation

//protocol NetworkServiceDelegate: class {
//    func updateInterface(_: NetworkService, currentWeather: CurrentWeather)
//}

class NetworkService {
    
//    weak var delegate: NetworkServiceDelegate?
    
  func fetchData(city: String, apiKey: String, completionHandler: @escaping (CurrentWeather)-> Void) {
        
       let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print( "Ooops i did it again", error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(WeatherCall.self, from: data)
                guard let currentWeather = CurrentWeather(weatherCall: json) else { return }
                completionHandler(currentWeather)
//              self.delegate?.updateInterface(self, currentWeather: currentWeather)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
}
