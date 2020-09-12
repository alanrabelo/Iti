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
    
    var detailView : DetailInvestimentView!

    // MARK: - Properties
    var viewModel: DetailInvestmentViewModel?


    // MARK: - View Life Cycle

    override func loadView() {

        detailView = DetailInvestimentView()
        
        detailView.delegate = self
        
        view = detailView
        
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

    override func viewDidLayoutSubviews() {

        if let view = self.view as? DetailInvestimentView {

            view.reloadSublayers()
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

extension DetailInvestimentViewController : DetailInvestimentViewDelegate {


    func exitButtonTapped() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func editInfosButtonTapped() {
        
        
    }
}


extension DetailInvestimentViewController {

    fileprivate func displayQuoteDetails(quote : Forex){

        if let unwrappedInvestiment = self.viewModel {

            DispatchQueue.main.sync {

                let initialValue = (unwrappedInvestiment.investment.quantity * unwrappedInvestiment.investment.price)

                let currentValue = (unwrappedInvestiment.investment.quantity * (Double(quote.price) ?? 0))

                let profitability = (currentValue - initialValue)/initialValue*100

                self.detailView.lbStockIdentifier.text = quote.symbol

                detailView.lbQuantityDescription.text          = String(unwrappedInvestiment.quantity)

                detailView.lbPrice.text           = unwrappedInvestiment.investment.price.formattedPrice

                detailView.lbDate.text            = formatDate(with: unwrappedInvestiment.investment.startDate ?? "")

                detailView.lbTotalValueText.text  = initialValue.formattedPrice

                detailView.lbTodayQuoteText.text  = quote.priceFormatted;

                detailView.lbTodayValueText.text  = currentValue.formattedPrice

                detailView.lbProfitability.text   = "\(Int(profitability))%"
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
