import UIKit

struct ColorPallete: Decodable {
    
    struct PalleteColor: Decodable {
        let sort_order: Int
        let description: String
        let red: Int
        let green: Int
        let blue: Int
        let alpha: Double
    }
    
    let palette_name: String
    let palette_info: String
    let palette_colors: [PalleteColor]
}

guard let sourcesURL = Bundle.main.url(forResource: "FlatColors", withExtension: "json") else {
    fatalError("Could not find Colors json file")
}

guard let colorData = try? Data(contentsOf: sourcesURL) else {
    fatalError("Could not convert data")
}

let decoder = JSONDecoder()
guard let flatColor = try? decoder.decode(ColorPallete.self, from: colorData) else {
    fatalError("Could not decode colors")
}
print(flatColor.palette_name)

for color in flatColor.palette_colors {
    print(color.description)
}
