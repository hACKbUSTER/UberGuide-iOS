import Foundation

class RideInfo {
    let type: String
    let message: String?
    let icon: NSURL?
    let lat: Double?
    let lon: Double?
    let description: String?
    let summary: String?
    let title: String?
    let detailTitle: String?
    
    init(type: String, message: String?, icon: NSURL?, lat: Double?, lon: Double?, description: String?, summary: String?, title: String?, detailTitle: String?) {
        self.type = type
        self.message = message
        self.icon = icon
        self.lat = lat
        self.lon = lon
        self.description = description
        self.summary = summary
        self.title = title
        self.detailTitle = detailTitle
    }
}
