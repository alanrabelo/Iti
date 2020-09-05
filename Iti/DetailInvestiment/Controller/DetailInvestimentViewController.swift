//
//  DetailInvestimentViewController.swift
//  Iti
//
//  Created by Marcos Lacerda on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

class DetailInvestimentViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var lbStockIdentifier            : UILabel!
    @IBOutlet weak var lbAmount                     : UILabel!
    @IBOutlet weak var lbPurchasePrice              : UILabel!
    @IBOutlet weak var lbQuantityDescription        : UILabel!
    @IBOutlet weak var lbPrice                      : UILabel!
    @IBOutlet weak var lbPurchaseDate               : UILabel!
    @IBOutlet weak var lbTotalValue                 : UILabel!
    @IBOutlet weak var lbDate                       : UILabel!
    @IBOutlet weak var lbTotalValueText             : UILabel!
    @IBOutlet weak var viewLine                     : UIView!
    @IBOutlet weak var lbTodayQuote                 : UILabel!
    @IBOutlet weak var lbTodayValue                 : UILabel!
    @IBOutlet weak var lbTodayQuoteText             : UILabel!
    @IBOutlet weak var lbTodayValueText             : UILabel!
    @IBOutlet weak var lbProfitabilityTitle         : UILabel!
    @IBOutlet weak var lbProfitability              : UILabel!
    @IBOutlet weak var btnEdit                      : UIButton!
    @IBOutlet weak var btnExit                      : UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        callExternalAPI(with: "itsa4")
        
    }
    
    // MARK: - Actions
   
    @IBAction func btnEdit(_ sender: Any, forEvent event: UIEvent) {
    
        
    }
    
    @IBAction func btnExit(_ sender: Any, forEvent event: UIEvent) {
    
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailInvestimentViewController {
    
    fileprivate func callExternalAPI(with symbol : String){
        
        ForexAPI.loadAction(withSymbol: symbol)
        { (result) in
            
            switch result {
                
                case .success(let forexQuote) : self.displayQuoteDetails(quote: forexQuote.quote)
                
                case .failure(let error)  : self.handleError(error: error)
            }
        }
    }
}


extension DetailInvestimentViewController {
    
    fileprivate func displayQuoteDetails(quote : Forex){
        
        DispatchQueue.main.sync {
            
            self.lbTodayQuoteText.text = quote.priceFormatted;
        }
        
    }
}

extension DetailInvestimentViewController {
    
    fileprivate func handleError(error : APIError){
        
    }
}
