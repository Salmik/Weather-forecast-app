import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.heavyrain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.show.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
            
        }
    }
    
    init?(weatherCall: WeatherCall){
        cityName = weatherCall.name
        temperature = weatherCall.main.temp
        feelsLikeTemperature = weatherCall.main.feelsLike
        conditionCode = weatherCall.weather.first!.id
    }
    
}
