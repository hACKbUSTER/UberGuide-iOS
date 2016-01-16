import Foundation

struct Tag {
    let id: String
    let text: String
    let icon: NSURL
    let enLabel: String
    
    init(id: String, text: String, icon: NSURL, enLabel: String) {
        self.id = id
        self.text = text
        self.icon = icon
        self.enLabel = enLabel
    }
}
