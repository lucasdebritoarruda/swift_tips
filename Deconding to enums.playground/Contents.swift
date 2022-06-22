import Foundation

let orderJSON =
"""
{
   "order": {
          "id": 12678,
          "status": "Shipped",
          "item": {
                "id": 1209,
                "handleWithCare": false
           }
    }
}
"""

enum OrderStatus: Decodable {
    case pending, approved, shipped, delivered, cancelled
    case unknown(value: String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
            case "Pending": self = .pending
            case "Approved": self = .approved
            case "Shipped": self = .shipped
            case "Delivered": self = .delivered
            case "Cancelled": self = .cancelled
            default: self = .unknown(value: status ?? "unknown")
        }
    }
}

struct OrderResponse: Decodable {
    
    struct Item: Decodable {
        let id: Int
        let handleWithCare: Bool
    }
    
    struct Order: Decodable {
        let id: Int
        let status: OrderStatus
        let item: Item
    }
    
    let order: Order
    
}

let orderJSONData = orderJSON.data(using: .utf8)!
let newDecoder = JSONDecoder()
let order = try! newDecoder.decode(OrderResponse.self, from: orderJSONData)
print(order.order.status)
