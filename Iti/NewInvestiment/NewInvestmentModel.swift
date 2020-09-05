import Foundation

struct NewInvestmentModel {
    
    var active: String
    var quantity: Double
    var price: Int
    var startDate: String
    
    init(withModel model: Investment?) {
        self.active = model?.active ?? ""
        self.startDate = model?.startDate ?? Date().asString
        self.quantity = model?.quantity ?? 0
        self.price = Int((model?.price ?? 0) * 100)
    }
}
