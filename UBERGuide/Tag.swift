import Foundation

struct Tag {
    let id: String
    let text: String
    let icon: NSURL
    
    init(id: String, text: String, icon: NSURL) {
        self.id = id
        self.text = text
        self.icon = icon
    }
}
