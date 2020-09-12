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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var buttonEye: UIButton!
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
        investmentView.tableView.delegate = self
        investmentView.tableView.dataSource = self
        viewModel.delegate = self
        setupView()
    }
    
    // MARK: - IBActions
    @IBAction func hideShowValue(_ sender: UIButton) {
        if sender.tag == 0 {
            buttonEye.setBackgroundImage(UIImage(systemName: "eye.fill"), for: .normal)
            labelValue.text = "R$ ----,--"
            sender.tag = 1
            print(sender.tag)
        } else {
            buttonEye.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
            labelValue.text = viewModel.totalAmount
            sender.tag = 0
            print(sender.tag)
        }
    }
    
    @IBAction func newInvestiment(_ sender: Any) {
//        self.performSegue(withIdentifier: "showForm", sender: nil)
        
        coordinator?.showNewInvestment(with: InvestmentViewModel(in: context))
    }
    
    // MARK: - Methods
    private func setupView() {
        let firstColor = UIColor(named: "MainOrange") ?? .white
        self.navigationController?.navigationBar.barTintColor = firstColor
    }
    
    @objc func newInvestment() {
//        self.performSegue(withIdentifier: "showForm", sender: nil)
        
        // TODO
//        let controller = NewInvestmentViewController()
//        controller.view = NewInvestmentView(textFieldDelegate: controller, investmentsModelDelegate: controller)
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
        
        coordinator?.showDetailInvestment(with: DetailInvestmentViewModel())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailInvestimentViewController {
            if let indexPath = sender as? IndexPath {
                let investment = viewModel.getInvestmentAt(indexPath)
                destination.investiment = investment
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
                destination.investiment = investment
            }
        }
    }
    
}

extension ListInvestmentsViewController: ListInvestmentsViewModelDelegate {
    func didUpdateList() {
        
        (view as! ListInvestmentsView).tableView.reloadData()
//        tableView.reloadData()
//        (view as! ListInvestmentsView).totalAmmountLabel.text = viewModel.totalAmount
    }
}
