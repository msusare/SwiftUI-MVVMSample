import UIKit

var str = "Hello, playground"

import Foundation
struct Welcome: Codable {
    let category: [Category]
}

struct Category: Codable {
    let vName: String
    let skill: [Skill]

    enum CodingKeys: String, CodingKey {
        case vName,skill
    }
}

struct Skill: Codable {
    let vName: String

    enum CodingKeys: String, CodingKey {

        case vName
    }
}

var cat : Welcome?

private func parseJSON(){

    guard let path = Bundle.main.path(forResource: "category", ofType: "json")else{
        return
    }

    let url = URL(fileURLWithPath: path)

    print(url)

    do {
        let jsonData = try Data(contentsOf: url)
        cat = try JSONDecoder().decode(Welcome.self, from: jsonData)
        if let result = cat {
            print(result)
        }
    } catch  {
        print("Error is \(error)")
    }


}

parseJSON()
//print(cat)
let searchText = "Section 0 Row 1"
let result = cat?.category.map({
    $0.skill.filter({$0.vName.lowercased().contains(searchText.lowercased())})
}).filter({ $0.count > 0 })

//let filteredArray = cat?.category.map({
//        return $0.filter({ $0.name == searchName })
//    }).filter({ $0.count > 0 })

print(result)

//let appleImage = UIImage(named: "avatar.jpg")!
//let imageData = UIImageJPEGRepresentation(appleImage, 1)!
//
//let blob = Blob(contentType: "image/jpeg", data: imageData)
//newTask.setBlob(blob, forKey: "avatar")
//try database.saveDocument(newTask)
//
//if let taskBlob = newTask.blob(forKey: "image") {
//    image = UIImage(data: taskBlob.content!)
//}
