//
//  DetailInvestimentViewController.swift
//  Iti
//
//  Created by Marcos Lacerda on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//

import UIKit

typealias HomeEnabled = Coordinator & ListInvestmentPresenter

class DetailInvestimentViewController: UIViewController, HasCodeView {

    typealias CustomView = DetailInvestimentView
    weak var coordinator: DetailInvestmentCoordinator?
    
    // MARK: - Properties
    var viewModel: DetailInvestmentViewModel?


    // MARK: - View Life Cycle

    override func loadView() {

        let detailView = DetailInvestimentView()
        view = detailView
//        view.lbStockIdentifier.text = viewModel?.active

        detailView.lbQuantityDescription.text = viewModel?.quantity

        detailView.lbPrice.text = viewModel?.price

        detailView.lbDate.text = viewModel?.startDate

//        detailView.lbTotalValueText.text  = initialValue.formattedPrice
//
//        detailView.lbTodayQuoteText.text  = quote.priceFormatted;
//
//        detailView.lbTodayValueText.text  = currentValue.formattedPrice
//
//        detailView.lbProfitability.text   = "\(Int(profitability))%"
    }

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        if let unwrappedInvestiment = self.viewModel {

            let unwrappedSymbol = unwrappedInvestiment.active

            viewModel?.callExternalAPI(with: unwrappedSymbol)  { (result) in

                switch result {

                case .success(let forexQuote) : self.displayQuoteDetails(quote: forexQuote.quote)

                case .failure(let error)  : self.handleError(error: error)
                }
            }

        }
    }

    private func goToHome() {
        coordinator?.showHome()
    }

    deinit {
        coordinator?.childDidFinish(nil)
        print("DetailInvestimentViewController deinit")
    }
}

extension DetailInvestimentViewController {


}


extension DetailInvestimentViewController {

    fileprivate func displayQuoteDetails(quote : Forex){

        if let unwrappedInvestiment = self.viewModel {

            DispatchQueue.main.sync {

//                let initialValue = (unwrappedInvestiment.quantity * unwrappedInvestiment.price)
//
//                let currentValue = (unwrappedInvestiment.quantity * (Double(quote.price) ?? 0))
//
//                let profitability = (currentValue - initialValue)/initialValue*100
//
//                                self.lbStockIdentifier.text = quote.symbol
//
//                                self.lbQuantityDescription.text          = String(unwrappedInvestiment.quantity)
//
//                                self.lbPrice.text           = unwrappedInvestiment.price.formattedPrice
//
//                                self.lbDate.text            = formatDate(with: unwrappedInvestiment.startDate ?? "")
//
//                                self.lbTotalValueText.text  = initialValue.formattedPrice
//
//                                self.lbTodayQuoteText.text  = quote.priceFormatted;
//
//                                self.lbTodayValueText.text  = currentValue.formattedPrice
//
//                                self.lbProfitability.text   = "\(Int(profitability))%"
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
