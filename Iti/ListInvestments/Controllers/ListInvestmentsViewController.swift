import UIKit

class ListInvestmentsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    // MARK: - Properties
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupView()
        
        ForexAPI.loadAction(withSymbol: "PETR4") {[weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .failure(let apiError):
                print("Falha")
                print(apiError.errorMessage)
            case .success(let forex):
                print(forex.quote.priceFormatted)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Methods
    private func setupView() {
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        let gradientColorTopView = UIColor.gradientColorFor(view: topView, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!, endPoint: CGPoint(x: 1.5, y: 0.0))
        //let gradientColorNavigation = UIColor.gradientColorFor(view: self.navigationController!.navigationBar, firstColor: UIColor(named: "MainOrange")!, secondColor: UIColor(named: "MainPink")!, endPoint: CGPoint(x: 1.5, y: 0.0))
        topView.layer.insertSublayer(gradientColorTopView, at: 0)
        //navigationController?.navigationBar.layer.insertSublayer(gradientColorNavigation, at: 0)
    }
}

extension ListInvestmentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let title = "Editar"

        let action = UIContextualAction(style: .normal, title: title,
          handler: { (action, view, completionHandler) in
        })
        action.backgroundColor = UIColor(named: "MainOrange")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}
