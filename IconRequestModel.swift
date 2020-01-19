//
//  IconRequestModel.swift
//  sAssist
//
//  Created by Lora Kucher on 17.01.2020.
//  Copyright © 2020 Lora Kucher. All rights reserved.
//

import Foundation

final class IconModel: Codable {
    
    var id: Int
    var category_id: Int
    var name: String
    var icon_name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case category_id
        case name
        case icon_name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.category_id = try container.decode(Int.self, forKey: .category_id)
        self.icon_name = try container.decode(String.self, forKey: .icon_name)
    }
}

final class IconList: Codable {
    
    var lists: [IconModel]
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        lists = try container.decodeArray(IconModel.self)
    }
}

final class IconRequestModel {
    
    class func getIconList(completion: @escaping ([IconModel]) -> Void) {
        guard let url = URL(string: "\(Constants.url)\(Request.item_types)") else {
            preconditionFailure("url is nil")
        }
        ServiceHelper.requestWithUrlencoded(with: url, parameters: nil, method: "GET") { dataResponse in
            do {
                let parsedResult: IconList = try JSONDecoder().decode(IconList.self, from: dataResponse)
                completion(parsedResult.lists)
            } catch {
                RequestError.getError(with: dataResponse)
            }
        }
    }
}
