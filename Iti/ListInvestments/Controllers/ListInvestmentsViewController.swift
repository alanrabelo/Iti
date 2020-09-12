//
//  ListInvestmentsViewController.swift
//  Iti
//
//  Created by Italus Rodrigues do Prado on 05/09/20.
//  Copyright © 2020 Alan Rabelo Martins. All rights reserved.
//
import UIKit
import CoreData

typealias DetailEnabled = Coordinator & DetailInvestmentPresenter & NewInvestmentPresenter

class ListInvestmentsViewController: UIViewController {

    // MARK: - IBOutlets
    weak var coordinator: DetailEnabled?

    // MARK: - Properties
    lazy var viewModel = ListInvestmentsViewModel(context: context)

    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 22))
        label.text = "Sem ações cadastradas"
        label.textAlignment = .center
        return label
    }()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let investmentView = ListInvestmentsView()
        investmentView.newInvestmentButton.addTarget(self, action: #selector(newInvestment), for: .touchUpInside)
        view = investmentView
        investmentView.delegate = self
        investmentView.tableView.delegate = self
        investmentView.tableView.dataSource = self
        viewModel.delegate = self
        setupView()
    }

    override func viewDidLayoutSubviews() {
        if let view = self.view as? ListInvestmentsView {
            view.reloadSublayers()
        }
    }

    // MARK: - IBActions
    @IBAction func hideShowValue(_ sender: UIButton) {

    }

    @IBAction func newInvestiment(_ sender: Any) {
        coordinator?.showNewInvestment(with: InvestmentViewModel(in: context))
    }

    // MARK: - Methods
    private func setupView() {
        if let view = self.view as? ListInvestmentsView {
            view.totalAmmountLabel.text = viewModel.totalAmount
        }
        let firstColor = UIColor(named: "MainOrange") ?? .white
        self.navigationController?.navigationBar.barTintColor = firstColor
    }

    @objc func newInvestment() {

        coordinator?.showNewInvestment(with: InvestmentViewModel(in: context))
    }

    deinit {
        coordinator?.childDidFinish(nil)
        print("ListInvestmentsViewController deinit")
    }
}

extension ListInvestmentsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = viewModel.count == 0 ? label : nil
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListInvestmentsTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.getInvestmentCellViewModelFor(indexPath))

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete { viewModel.deleteInvestment(indexPath) }

    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let title = "Editar"

        let action = UIContextualAction(style: .normal, title: title,
                                        handler: { (action, view, completionHandler) in

                                            let investment = self.viewModel.getInvestmentAt(indexPath)
                                            let viewModel = InvestmentViewModel(withModel: investment, in: self.context)

                                            guard let navigationController = self.navigationController else { return }
                                            let editInvestmentCoordinator = NewInvestmentCoordinator(navigationController: navigationController, newInvestmentViewModel: viewModel)
                                            self.coordinator?.add(childCoordinator: editInvestmentCoordinator)
                                            editInvestmentCoordinator.start()
        })

        action.backgroundColor = UIColor(named: "MainOrange")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        performSegue(withIdentifier: "SegueDetail", sender: indexPath)

        coordinator?.showDetailInvestment(with: DetailInvestmentViewModel(investment:  viewModel.getInvestmentAt(indexPath)))
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? DetailInvestimentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = viewModel.getInvestmentAt(indexPath)
//                destination.investiment = investment
            }
        }
        if let destination = segue.destination as? NewInvestmentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = viewModel.getInvestmentAt(indexPath)
                destination.viewModel = InvestmentViewModel(withModel: investment, in: context)
            }
        }

        if let destination = segue.destination as? DetailInvestimentViewController {

            if let indexPath = sender as? IndexPath {
                let investment = viewModel.getInvestmentAt(indexPath)
//                destination.investiment = investment
            }
        }
    }

}

extension ListInvestmentsViewController: ListInvestmentsViewModelDelegate {
    func didUpdateList() {
        if let view = self.view as? ListInvestmentsView {
            view.tableView.reloadData()
            view.totalAmmountLabel.text = viewModel.totalAmount
        }
    }
}

extension ListInvestmentsViewController: ListInvestmentsViewDelegate {
    func changeTotalLabel(tag: Int) {
        guard let view = self.view as? ListInvestmentsView else { return }
        if tag == 0 {
            view.eyeButton.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
            view.totalAmmountLabel.text = "R$ ----,--"
            view.eyeButton.tag = 1
        } else {
            view.eyeButton.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
            view.totalAmmountLabel.text = viewModel.totalAmount
            view.eyeButton.tag = 0
        }
    }
}
