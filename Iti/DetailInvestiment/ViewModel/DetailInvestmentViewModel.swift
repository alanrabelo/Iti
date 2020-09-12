import Foundation

class DetailInvestmentViewModel {
    
     private var investment: Investment
    
     init(investment: Investment) {
       self.investment = investment
     }
    
    var quantity: Double {
        return investment.quantity
    }
    
    var price: Double {
        return investment.price
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
