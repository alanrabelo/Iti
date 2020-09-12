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

    // MARK: - Properties

    var investiment : Investment?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {

        if let unwrappedInvestiment = self.investiment {

            if let unwrappedSymbol = unwrappedInvestiment.active {

                callExternalAPI(with: unwrappedSymbol)
            }
        }
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

       if let unwrappedInvestiment = self.investiment {

            DispatchQueue.main.sync {

                let initialValue = (unwrappedInvestiment.quantity * unwrappedInvestiment.price)
                
                let currentValue = (unwrappedInvestiment.quantity * (Double(quote.price) ?? 0))
                
                let profitability = (currentValue - initialValue)/initialValue*100
                
                self.lbStockIdentifier.text = quote.symbol

                self.lbQuantityDescription.text          = String(unwrappedInvestiment.quantity)

                self.lbPrice.text           = unwrappedInvestiment.price.formattedPrice

                self.lbDate.text            = formatDate(with: unwrappedInvestiment.startDate ?? "")

                self.lbTotalValueText.text  = initialValue.formattedPrice

                self.lbTodayQuoteText.text  = quote.priceFormatted;

                self.lbTodayValueText.text  = currentValue.formattedPrice
                
                self.lbProfitability.text   = "\(Int(profitability))%"
            }
        }
    }
}

extension DetailInvestimentViewController {

    fileprivate func handleError(error : APIError){


    }
}

extension DetailInvestimentViewController {

    fileprivate func formatDate(with dateString : String) -> String{

        let dateFormatterGet = DateFormatter()

        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()

        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date = dateFormatterGet.date(from: dateString) {

            return dateFormatterPrint.string(from: date)
        }

        return ""
    }
}
