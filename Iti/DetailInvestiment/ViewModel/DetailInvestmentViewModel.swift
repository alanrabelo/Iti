import Foundation

class DetailInvestmentViewModel {
    
     public var investment: Investment

     init(investment: Investment) {
         self.investment = investment
     }

     var quantity: String {
         return "\(investment.quantity)"
     }

     var price: String {
         return investment.price.formattedPrice
     }

     var active: String {
         return investment.active!
     }

     var startDate: String {
         return investment.startDate!
     }
    
    func callExternalAPI(with symbol : String, onComplete: @escaping (Result<ForexQuote, APIError>) -> Void){

        ForexAPI.loadAction(withSymbol: symbol, onComplete: onComplete)
    }

}
