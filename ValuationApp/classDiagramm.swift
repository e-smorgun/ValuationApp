////
////  AuthRegModel.swift
////  ValuationApp
////
////  Created by Evgeny on 8.12.22.
////
//
//class User {
//    var userID: String = ""
//    var userName: String = ""
//    var userEmail: String = ""
//    var userRole: String = ""
//    var userPhone: String = ""
//
//
//    init(userID: String, userName: String, userEmail: String, userRole: String, userPhone: String) {
//        self.userID = userID
//        self.userName = userName
//        self.userEmail = userEmail
//        self.userRole = userRole
//        self.userPhone = userPhone
//    }
//}
//
//
//class Property {
//    var address: String = ""
//    var floor: Int = 0
//    var square: Int = 0
//    var metro: Int = 0
//    var cost_per_square_meter: Double = 0
//    var full_cost: Double = 0
//    var balcony: String = ""
//    var bathroom: String = ""
//    var material: String = ""
//    var finishing_work: String = ""
//    var property_type: String = ""
//    var region: String = ""
//    var view_from_window = ""
//    var userID = ""
//    var valuerID = ""
//
//    init(address: String, floor: Int, square: Int, metro: Int, cost_per_square_meter: Double, full_cost: Double, balcony: String, bathroom: String, material: String, finishing_work: String, property_type: String, region: String, view_from_window: String = "", userID: String = "") {
//        self.address = address
//        self.floor = floor
//        self.square = square
//        self.metro = metro
//        self.cost_per_square_meter = cost_per_square_meter
//        self.full_cost = full_cost
//        self.balcony = balcony
//        self.bathroom = bathroom
//        self.material = material
//        self.finishing_work = finishing_work
//        self.property_type = property_type
//        self.region = region
//        self.view_from_window = view_from_window
//        self.userID = userID
//    }
//}
//
//
//class Support {
//    var message: String = ""
//    var user: String = ""
//
//    init(message: String, user: String) {
//        self.message = message
//        self.user = user
//    }
//}
//
//enum ValuerTabBarPage {
//    case orders
//    case analogs
//    case users
//    case setting
//
//    init?(index: Int) {
//        switch index {
//        case 0:
//            self = .orders
//        case 1:
//            self = .analogs
//        case 2:
//            self = .users
//        case 3:
//            self = .setting
//        default:
//            return nil
//        }
//    }
//
//    func pageTitleValue() -> String {
//        switch self {
//        case .orders:
//            return "Заказы"
//        case .analogs:
//            return "Аналоги"
//        case .users:
//            return "Работа с пользователями"
//        case .setting:
//            return "Настройки"
//        }
//    }
//
//    func pageOrderNumber() -> Int {
//        switch self {
//        case .orders:
//            return 0
//        case .analogs:
//            return 1
//        case .users:
//            return 2
//        case .setting:
//            return 3
//        }
//    }
//}
//
//protocol TabBarValuerCoordinator: Coordinator {
//    var tabBarController: UITabBarController { get set }
//
//    func selectPage(_ page: TabBarPage)
//
//    func setSelectedIndex(_ index: Int)
//
//    func currentPage() -> TabBarPage?
//}
//
//class TabValuerCoordinator: NSObject, Coordinator {
//    weak var finishDelegate: CoordinatorFinishDelegate?
//
//    var childCoordinators: [Coordinator] = []
//    var navigationController: UINavigationController
//    var tabBarController: UITabBarController
//
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = .init()
//    }
//
//    func start() {
//        let pages: [ValuerTabBarPage] = [.orders, .analogs, .users, .setting]
//            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
//        tabBarController.tabBar.backgroundColor = .white
//        tabBarController.tabBar.tintColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1)
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//
//
//        prepareTabBarController(withTabControllers: controllers)
//    }
//
//    deinit {
//        print("TabCoordinator deinit")
//    }
//
//    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
//        tabBarController.delegate = self
//        tabBarController.setViewControllers(tabControllers, animated: true)
//        tabBarController.selectedIndex = ValuerTabBarPage.orders.pageOrderNumber()
//        tabBarController.tabBar.isTranslucent = false
//
//        navigationController.viewControllers = [tabBarController]
//    }
//
//    private func getTabController(_ page: ValuerTabBarPage) -> UINavigationController {
//        let navController = UINavigationController()
//        navController.setNavigationBarHidden(false, animated: false)
//
//        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
//                                                     image: nil,
//                                                     tag: page.pageOrderNumber())
//
//        switch page {
//        case .orders:
//            let orderVC = OrdersViewController.createObject()
//            navController.pushViewController(orderVC, animated: true)
////            let menuVC = MenuViewController.createObject()
////            menuVC.didGoToInfoController = { [weak self] coffee in
////                self?.showInfoController(coffee: coffee)
////            }
////         navController.pushViewController(menuVC, animated: true)
//        case .analogs:
//            let analogsVC = AnalogsViewController.createObject()
//            analogsVC.didSendEventClosure = { [weak self] in
//                self?.showFirstNewAnalog()
//            }
//            navController.pushViewController(analogsVC, animated: true)
////            let giftVC = GiftViewController.createObject()
////            navController.pushViewController(giftVC, animated: true)
//        case .users:
//            let usersVC = WorkWithUsersViewController.createObject()
//            usersVC.didGoToSupportEventClosure = { [weak self] in
//                self?.showSupportRequest()
//            }
//
//            usersVC.didGoToStatisticsEventClosure = { [weak self] in
//                self?.showStatistics()
//            }
//
//            navController.pushViewController(usersVC, animated: true)
////            let orderVC = OrderViewController.createObject()
////            orderVC.orders = orders
////            orderVC.didClearOrder = { [weak self] in
////                self?.orders.removeAll()
////            }
////            navController.pushViewController(orderVC, animated: true)
//        case .setting:
//            let accountVC = AccountViewController.createObject()
//            navController.pushViewController(accountVC, animated: true)
////            let accountVC = AccountViewController.createObject()
////            navController.pushViewController(accountVC, animated: true)
//        }
//
//        return navController
//    }
//}
//
//extension TabValuerCoordinator {
//    func showFirstNewAnalog() {
//        let newAnalog = FirstNewAnalogViewController.createObject()
//        newAnalog.didSendEventClosure = { [weak self] newAnalog in
//            self?.showSecondNewAnalog(analog: newAnalog)
//        }
//        navigationController.pushViewController(newAnalog, animated: true)
//    }
//
//    func showSecondNewAnalog(analog: Property) {
//        let newAnalog = SecondNewAnalogViewController.createObject()
//        newAnalog.newAnalog = analog
//        newAnalog.didSendEventClosure = { [weak self] in
//            self?.start()
//        }
//        navigationController.pushViewController(newAnalog, animated: true)
//    }
//
//    func showSupportRequest() {
//        let supportVC = SupportRequestViewController.createObject()
//        supportVC.didSendEventClosure = { [weak self] in
//            self?.start()
//        }
//        navigationController.pushViewController(supportVC, animated: true)
//    }
//
//    func showStatistics() {
//        let statisticsVC = StatisticsViewController.createObject()
//        statisticsVC.didSendEventClosure = { [weak self] in
//            self?.start()
//        }
//        navigationController.pushViewController(statisticsVC, animated: true)
//    }
//}
//
//// MARK: - UITabBarControllerDelegate
//extension TabValuerCoordinator: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController,
//                          didSelect viewController: UIViewController) {
//    }
//}
//
//
//
//enum TabBarPage {
//    case myOrder
//    case account
//
//    init?(index: Int) {
//        switch index {
//        case 0:
//            self = .myOrder
//        case 1:
//            self = .account
//        default:
//            return nil
//        }
//    }
//
//    func pageTitleValue() -> String {
//        switch self {
//        case .myOrder:
//            return "myOrder"
//        case .account:
//            return "Account"
//        }
//    }
//
//    func pageOrderNumber() -> Int {
//        switch self {
//        case .myOrder:
//            return 0
//        case .account:
//            return 1
//        }
//    }
//}
//
//protocol TabCoordinatorProtocol: Coordinator {
//    var tabBarController: UITabBarController { get set }
//
//    func selectPage(_ page: TabBarPage)
//
//    func setSelectedIndex(_ index: Int)
//
//    func currentPage() -> TabBarPage?
//}
//
//class TabCoordinator: NSObject, Coordinator {
//    weak var finishDelegate: CoordinatorFinishDelegate?
//
//    var childCoordinators: [Coordinator] = []
//    var navigationController: UINavigationController
//    var tabBarController: UITabBarController
//
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        self.tabBarController = .init()
//    }
//
//    func start() {
//        let pages: [TabBarPage] = [.myOrder, .account]
//            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
//        tabBarController.tabBar.backgroundColor = .white
//        tabBarController.tabBar.tintColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1)
//        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
//
//
//        prepareTabBarController(withTabControllers: controllers)
//    }
//
//    deinit {
//        print("TabCoordinator deinit")
//    }
//
//    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
//        tabBarController.delegate = self
//        tabBarController.setViewControllers(tabControllers, animated: true)
//        tabBarController.selectedIndex = TabBarPage.myOrder.pageOrderNumber()
//        tabBarController.tabBar.isTranslucent = false
//
//        navigationController.viewControllers = [tabBarController]
//    }
//
//    private func getTabController(_ page: TabBarPage) -> UINavigationController {
//        let navController = UINavigationController()
//        navController.setNavigationBarHidden(false, animated: false)
//
//        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
//                                                     image: nil,
//                                                     tag: page.pageOrderNumber())
//
//        switch page {
//        case .myOrder:
//            let myOrderVC = MyOrderViewController.createObject()
//            myOrderVC.didSendEventClosure = { [weak self] in
//                self?.showFirstAddNewOrder()
//            }
//            navController.pushViewController(myOrderVC, animated: true)
//        case .account:
//            let accountVC = AccountViewController.createObject()
//            accountVC.didSendEventClosure = { [weak self] in
//                self?.showSupportViewController()
//            }
//            navController.pushViewController(accountVC, animated: true)
//        }
//
//        return navController
//    }
//}
//
//extension TabCoordinator {
//    func showSupportViewController() {
//        let SupportVC = SupportViewController.createObject()
//        SupportVC.didSendEventClosure = { [weak self] in
//            self?.start()
//        }
//        navigationController.pushViewController(SupportVC, animated: true)
//    }
//
//    func showFirstAddNewOrder() {
//        let newOrder = FirstNewAnalogViewController.createObject()
//        newOrder.didSendEventClosure = { [weak self] newOrderToDB in
//            self?.showSecondAddNewOrder(order: newOrderToDB)
//        }
//        navigationController.pushViewController(newOrder, animated: true)
//    }
//
//    func showSecondAddNewOrder(order: Property) {
//        let newObject = AddNewObjectViewController.createObject()
//        newObject.newObject = order
//        newObject.didSendEventClosure = { [weak self] in
//            self?.start()
//        }
//        navigationController.pushViewController(newObject, animated: true)
//    }
//}
//
//// MARK: - UITabBarControllerDelegate
//extension TabCoordinator: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController,
//                          didSelect viewController: UIViewController) {
//    }
//}
//
//
//protocol AppCoordinatorProtocol: Coordinator {
//    func showLoginFlow()
//    func showMainFlow()
//}
//
//class AppCoordinator: AppCoordinatorProtocol {
//    weak var finishDelegate: CoordinatorFinishDelegate? = nil
//
//    var navigationController: UINavigationController
//
//    var childCoordinators = [Coordinator]()
//
//    var ref: DatabaseReference!
////    var role: String = ""
//
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//        navigationController.setNavigationBarHidden(true, animated: true)
//    }
//
//    func start() {
//        showLoginFlow()
//    }
//
//    func showLoginFlow() {
//        let authCoordinator = AuthCoordinator.init(navigationController)
//        authCoordinator.start()
//        childCoordinators.append(authCoordinator)    }
//
//    func showMainFlow() {
//        ref = Database.database().reference()
//        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : NSDictionary] {
//                for (_, value) in value {
//                    if value["id"]! as? String == Auth.auth().currentUser?.uid {
//                        if value["role"] as! String == "1" {
//                            let tabCoordinator = TabCoordinator.init(self.navigationController)
//                            tabCoordinator.start()
//                            self.childCoordinators.append(tabCoordinator)
//                        }; if value["role"] as! String == "2"{
//                            let tabValuerCoordinator = TabValuerCoordinator.init(self.navigationController)
//                            tabValuerCoordinator.start()
//                            self.childCoordinators.append(tabValuerCoordinator)
//                        }
//                    }
//                }
//            }
//        }) { error in
//        print(error.localizedDescription)
//        }
//    }
//
//    func loadUserRole(userID: String) {
//        var user: User = User(userID: "", userName: "", userEmail: "", userRole: "", userPhone: "")
//
//        ref = Database.database().reference()
//        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : NSDictionary] {
//                for (_, value) in value {
//                    if value["id"]! as? String == userID {
//                        let user1: User = User(userID: value["id"] as! String ,
//                                               userName: value["name"] as! String,
//                                               userEmail: value["mail"] as! String,
//                                               userRole: value["role"] as! String,
//                                               userPhone: value["userPhone"] as! String)
//                        user = user1
//                    }
//                }
//            }
//        }) { error in
//        print(error.localizedDescription)
//        }
//    }
//}
//
//
//protocol Coordinator: AnyObject {
//    var finishDelegate: CoordinatorFinishDelegate? { get set }
//    var navigationController: UINavigationController { get set }
//    var childCoordinators: [Coordinator] { get set }
//    func start()
//    func finish()
//
//    init(_ navigationController: UINavigationController)
//}
//
//extension Coordinator {
//    func finish() {
//        childCoordinators.removeAll()
//        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
//    }
//}
//
//// MARK: - CoordinatorOutput
//protocol CoordinatorFinishDelegate: AnyObject {
//    func coordinatorDidFinish(childCoordinator: Coordinator)
//}
//
//
//class AddNewObjectViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//
//    @IBOutlet var rootView: AddNewObjectView!
//    var newObject: Property!
//    var viewModel = AddNewObjectViewModel()
//    var disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rootView.nextPageButton.rx.tap.subscribe(onNext: { [weak self]  in
//
//            self?.newObject.address = self?.rootView.addressTF.text ?? ""
//            self?.newObject.floor = Int(self?.rootView.floorTF.text ?? "") ?? 0
//            self?.newObject.square = Int(self?.rootView.squareTF.text ?? "") ?? 0
//            self?.newObject.metro = Int(self?.rootView.metroTF.text ?? "") ?? 0
//            self?.viewModel.addNewObjectToDataBase(object: (self?.newObject)!)
//            self?.didSendEventClosure?()
//        })
//    }
//
//    @IBAction func switchPressed(_ sender: UISwitch ) {
//        switch sender.isOn {
//        case true:
//            newObject.balcony = "Есть"
//        case false:
//            newObject.balcony = "Отсутствует"
//        }
//    }
//}
//
//class AddNewObjectView: UIView {
//    @IBOutlet var nextPageButton: UIButton! {
//        didSet{
//            nextPageButton.layer.cornerRadius = 23
//        }
//    }
//
//    @IBOutlet weak var metroTF: UITextField!
//    @IBOutlet weak var squareTF: UITextField!
//    @IBOutlet weak var floorTF: UITextField!
//    @IBOutlet weak var addressTF: UITextField!
//}
//
//
//class AddNewObjectViewModel {
//
//    var ref: DatabaseReference!
//
//    func addNewObjectToDataBase(object: Property) {
//        object.property_type = "Order"
//        print("userID: ", object.userID,
//              "bathroom: ", object.bathroom,
//              "region: " , object.region,
//              "finishing_work: ", object.finishing_work,
//              "material: ", object.material,
//              "view_from_window: ", object.view_from_window,
//              "square: ", object.square,
//              "cost_per_square_meter: ", object.cost_per_square_meter,
//              "address: ", object.address,
//              "balcony: ", object.balcony,
//              "full_cost: ", object.full_cost,
//              "floor: ", object.floor,
//              "metro: ", object.metro,
//              "property_type: ", object.property_type)
//
//        var analogsArr: [Property] = []
//
//        ref = Database.database().reference()
//        ref.child("property").observeSingleEvent(of: .value, with: { [self] (snapshot) in
//            if let value = snapshot.value as? [String : NSDictionary] {
//                for (_, value) in value {
//                    if value["property_type"]! as? String == "Analog" {
//                            let analog: Property = Property(address: value["address"] as! String,
//                                                            floor: value["floor"] as! Int,
//                                                            square: value["square"] as! Int,
//                                                            metro: value["metro"] as! Int ,
//                                                            cost_per_square_meter: value["cost_per_square_meter"] as! Double,
//                                                            full_cost: value["full_cost"] as! Double,
//                                                            balcony: value["balcony"] as! String ,
//                                                            bathroom: value["bathroom"] as! String ,
//                                                            material: value["material"] as! String,
//                                                            finishing_work: value["finishing_work"] as! String,
//                                                            property_type: value["property_type"] as! String,
//                                                            region: value["region"] as! String,
//                                                            view_from_window: value["view_from_window"] as! String,
//                                                            userID: value["userID"] as! String)
//                            analogsArr.append(analog)
//                    }
//                }
//            }
//
//            var objectsArrToCompare: [Property] = []
//
//
//            for property in analogsArr {
//                if (property.region == object.region) {
//                    if (objectsArrToCompare.count == 3) {
//                        break
//                    } else {
//                        objectsArrToCompare.append(property)
//                    }
//                }
//            }
//
//            self.compareObject(analogArray: objectsArrToCompare, object: object)
//
//        }) { error in
//        print(error.localizedDescription)
//        }
//    }
//
//    func compareObject(analogArray: [Property], object: Property) {
//        var costPerSqMeterArr: [Double] = []
//
//        for array in analogArray {
//            if object.view_from_window == "Солнечная сторона" {
//                if (array.view_from_window != "Солнечная сторона") {
//                    array.cost_per_square_meter *= 0.93
//                }
//            }
//            //------------------------------------------------------------------------------------------------------
//            if object.material == "Кирпич" {
//                if array.material == "Панели" {
//                    array.cost_per_square_meter *= 1.02
//                } else if array.material == "Блок" {
//                    array.cost_per_square_meter *= 0.98
//                }
//            } else if object.material == "Панели" {
//                if array.material == "Кирпич" {
//                    array.cost_per_square_meter *= 0.98
//                } else if array.material == "Блок" {
//                    array.cost_per_square_meter *= 0.96
//                }
//            } else if object.material == "Блок" {
//                if array.material == "Кирпич" {
//                    array.cost_per_square_meter *= 1.02
//                } else if array.material == "Панели" {
//                    array.cost_per_square_meter *= 1.04
//                }
//            }
//            //------------------------------------------------------------------------------------------------------
//            if object.bathroom == "Раздельный" {
//                if (array.bathroom != "Раздельный") {
//                    array.cost_per_square_meter *= 0.93
//                }
//            }
//            //------------------------------------------------------------------------------------------------------
//            if object.floor == 1 {
//                if array.floor > 1 && array.floor < 4 {
//                    array.cost_per_square_meter *= 1.03
//                } else if array.floor > 3 && array.floor < 6 {
//                    array.cost_per_square_meter *= 1.05
//                } else if array.floor > 5 {
//                    array.cost_per_square_meter *= 1.04
//                }
//            } else if object.floor > 1 && object.floor < 4 {
//                if array.floor == 1 {
//                    array.cost_per_square_meter *= 0.98
//                } else if array.floor > 3 && array.floor < 6 {
//                    array.cost_per_square_meter *= 1.03
//                } else if array.floor > 5 {
//                    array.cost_per_square_meter *= 1.02
//                }
//            } else if object.floor > 3 && object.floor < 6 {
//                if array.floor == 1 {
//                    array.cost_per_square_meter *= 0.95
//                } else if array.floor > 1 && array.floor < 4 {
//                    array.cost_per_square_meter *= 1.02
//                } else if array.floor > 5 {
//                    array.cost_per_square_meter *= 1.01
//                }
//            } else if object.floor > 5 {
//                if array.floor == 1 {
//                    array.cost_per_square_meter *= 0.96
//                } else if array.floor > 1 && array.floor < 4 {
//                    array.cost_per_square_meter *= 0.98
//                } else if array.floor > 3 && array.floor < 6 {
//                    array.cost_per_square_meter *= 1.01
//                }
//            }
//
//            costPerSqMeterArr.append(array.cost_per_square_meter)
//        }
//        //------------------------------------------------------------------------------------------------------
//        var sum: Double = costPerSqMeterArr.reduce(0, +)
//        sum /= Double(costPerSqMeterArr.count)
//        sum *= 100.0
//        var buffer = Int(sum)
//        object.cost_per_square_meter = Double(buffer) / 100.0
//        //------------------------------------------------------------------------------------------------------
//        object.full_cost = object.cost_per_square_meter * Double(object.square)
//
//
//        let ref = Database.database().reference().child("property")
//
//        ref.childByAutoId().updateChildValues(["userID": object.userID ,
//                                               "address": object.address ,
//                                               "floor": object.floor,
//                                               "square": object.square,
//                                               "metro": object.metro,
//                                               "cost_per_square_meter": object.cost_per_square_meter,
//                                               "full_cost": object.full_cost,
//                                               "balcony": object.balcony,
//                                               "bathroom": object.bathroom,
//                                               "finishing_work": object.finishing_work,
//                                               "property_type": object.property_type,
//                                               "region": object.region,
//                                               "view_from_window": object.view_from_window,
//                                               "material": object.material])
//    }
//}
//
//
//class AccountViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//
//    @IBOutlet weak var logoutButton: UIButton!
//    @IBOutlet var rootView: AccountView!
//
//    var ref: DatabaseReference!
//    var disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rootView.logoutButton.rx.tap.subscribe(onNext: { [weak self]  in
//            do {
//                try Auth.auth().signOut()
//                print("logout")
//            } catch {
//                print(error)
//            }
//        }).disposed(by: disposeBag)
//
//        rootView.supportButton.rx.tap.subscribe(onNext: { [weak self]  in
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//
//        ref = Database.database().reference()
//        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : NSDictionary] {
//                for (_, value) in value {
//                    if value["id"]! as? String == Auth.auth().currentUser?.uid {
//                        self.rootView.nameLabel.text = value["name"] as? String
//                        self.rootView.emailLabel.text = value["mail"] as? String
//                        if value["role"] as? String == "2" {
//                            self.rootView.supportButton.isHidden = true
//                        }
//                    }
//                }
//            }
//        }) { error in
//        print(error.localizedDescription)
//        }
//        rootView.emailLabel.text = Auth.auth().currentUser?.email
//        }
//}
//
//class AccountView: UIView {
//
//    @IBOutlet weak var nameLabel: UILabel!
//
//    @IBOutlet weak var emailLabel: UILabel!
//
//    @IBOutlet weak var logoutButton: UIButton! {
//        didSet {
//            logoutButton.layer.cornerRadius = 23
//         }
//    }
//
//    @IBOutlet weak var supportButton: UIButton! {
//        didSet {
//            supportButton.layer.cornerRadius = 23
//         }
//    }
//}
//
//class MyOrderViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//
//    var ref: DatabaseReference!
//    var disposeBag = DisposeBag()
//    var viewModel = MyOrderViewModel()
//
//    @IBOutlet weak var rootview: MyOrderView!
//    @IBOutlet weak var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = "Заказы"
//        tableView.register(UINib(nibName: "AnalogsCell", bundle: nil), forCellReuseIdentifier: "AnalogsCell")
//
//        viewModel.analogsArray.bind(to: tableView.rx.items(cellIdentifier: "AnalogsCell", cellType: AnalogsCell.self)) { index, item, cell in
//            cell.configure(analog: item)
//        }.disposed(by: disposeBag)
//
//        rootview.addNewOrderButton.rx.tap.subscribe(onNext: { [weak self]  in
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//
//        rootview.filterButton.rx.tap.subscribe(onNext: { [weak self]  in
//            let url: NSURL = URL(string: "TEL:375298312670")! as NSURL
//            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
//        }).disposed(by: disposeBag)
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            viewModel.loadData()
//    }
//
//
//}
//
//class MyOrderViewModel {
//    var analogsArray = BehaviorRelay<[Property]>(value: [])
//    var ref: DatabaseReference!
//
//    func loadData() {
//        var analogsArr: [Property] = []
//
//        ref = Database.database().reference()
//        ref.child("property").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String : NSDictionary] {
//                for (_, value) in value {
//                    if value["property_type"]! as? String == "Order" {
//                        if value["userID"]! as? String == Auth.auth().currentUser?.uid {
//                            var analog: Property = Property(address: value["address"] as! String,
//                                                            floor: value["floor"] as! Int,
//                                                            square: value["square"] as! Int,
//                                                            metro: value["metro"] as! Int ,
//                                                            cost_per_square_meter: value["cost_per_square_meter"] as! Double,
//                                                            full_cost: value["full_cost"] as! Double,
//                                                            balcony: value["balcony"] as! String ,
//                                                            bathroom: value["bathroom"] as! String ,
//                                                            material: value["material"] as! String,
//                                                            finishing_work: value["finishing_work"] as! String,
//                                                            property_type: value["property_type"] as! String,
//                                                            region: value["region"] as! String,
//                                                            view_from_window: value["view_from_window"] as! String,
//                                                            userID: value["userID"] as! String)
//                            analogsArr.append(analog)
//                        }
//                    }
//                }
//                self.analogsArray.accept(analogsArr)
//            }
//        }) { error in
//        print(error.localizedDescription)
//        }
//    }
//}
//
//class MyOrderView: UIView {
//    @IBOutlet weak var addNewOrderButton: UIButton!
//
//    @IBOutlet weak var filterButton: UIButton!
//}
//
//class SupportView: UIView {
//
//    @IBOutlet var sendButton: UIButton! {
//        didSet {
//            sendButton.layer.cornerRadius = 23
//        }
//    }
//
//    @IBOutlet weak var backButton: UIButton!
//
//    @IBOutlet weak var MessageTextField: UITextField!
//}
//
//class SupportViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//    var disposeBag = DisposeBag()
//    @IBOutlet var rootVeiw: SupportView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rootVeiw.sendButton.rx.tap.subscribe(onNext: { [weak self]  in
//            let ref = Database.database().reference().child("support_request")
//            ref.childByAutoId().updateChildValues(["user" : Auth.auth().currentUser?.uid ?? "",
//                                                   "message" : self?.rootVeiw.MessageTextField.text ?? ""])
//
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//
//        rootVeiw.backButton.rx.tap.subscribe(onNext: { [weak self]  in
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//        }
//}
//
//
//class RegistrationViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//    var disposeBag = DisposeBag()
//
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var loginTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var registerButton: UIButton!
//    @IBOutlet var goToSignInButton: UIButton!
//    @IBOutlet var rootVeiw: RegistrationView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        loginTextField.delegate = self
//        passwordTextField.delegate = self
//
//        registerButton.rx.tap.subscribe(onNext: { [weak self]  in
//            let name = self?.nameTextField.text!
//            let login = self?.loginTextField.text!
//            let password = self?.passwordTextField.text!
//
//            print(name, login, password)
//
//            if(!login!.isEmpty && !password!.isEmpty) {
//                Auth.auth().createUser(withEmail: login!, password: password!) { result, error in
//                    if error == nil {
//                        if let result = result {
//                            let ref = Database.database().reference().child("users")
//                            ref.child(result.user.uid).updateChildValues(["id" : Auth.auth().currentUser?.uid,
//                                                                          "name" : name!,
//                                                                          "mail" : login!,
//                                                                          "role": "1",
//                                                                          "userPhone": ""])
//
//                            self?.didSendEventClosure?()
//                        }
//                    }
//                    else {
//                        self?.showAlert(error: "The password must be 6 characters long or more.")
//                    }
//                }
//            } else {
//                self?.showAlert(error: "error")
//            }
//        }).disposed(by: disposeBag)
//
//        goToSignInButton.rx.tap.subscribe(onNext: { [weak self]  in
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//
//    }
//
//    deinit {
//        print("RegistrationViewController deinit")
//    }
//
//    func showAlert(error: String) {
//        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//extension RegistrationViewController {
//    enum Event {
//        case login
//    }
//}
//
//extension RegistrationViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let login = loginTextField.text!
//        let password = passwordTextField.text!
//
//        if(!login.isEmpty && !password.isEmpty) {
//            Auth.auth().createUser(withEmail: login, password: password) { result, error in
//                if error == nil {
//                    if let result = result {
//                        print(result.user.uid)
//                    }
//                }
//            }
//        } else {
//            showAlert(error: "Fill in all an Fields")
//        }
//        return true
//    }
//}
//
//class RegistrationView: UIView {
//
//    @IBOutlet weak var goToSignInButton: UIButton!
//
//    @IBOutlet var registerButton: UIButton! {
//        didSet {
//            registerButton.layer.cornerRadius = 23
//         }
//    }
//
//    @IBOutlet var nameTextField: UITextField! {
//        didSet {
//            nameTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
//            nameTextField.layer.cornerRadius = 100
//        }
//    }
//
//    @IBOutlet var loginTextField: UITextField! {
//        didSet {
//            loginTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
//            loginTextField.layer.cornerRadius = 100
//        }
//    }
//
//    @IBOutlet var passwordTextField: UITextField! {
//        didSet {
//            passwordTextField.layer.cornerRadius = 23
//            passwordTextField.layer.borderColor = UIColor(red: 0.294, green: 0.29, blue: 0.459, alpha: 1).cgColor
//        }
//    }
//}
//
//class AuthorizationViewController: UIViewController, Storyboardable {
//
//    var didSendEventClosure: (() -> Void)?
//    var didAuthClosure: (() -> Void)?
//    var disposeBag = DisposeBag()
//    var coordinator: AuthCoordinator?
//
//    @IBOutlet var goToRegButton: UIButton!
//    @IBOutlet var AuthButton: UIButton!
//    @IBOutlet var rootView: AuthorizationView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        AuthButton.rx.tap.subscribe(onNext: { [weak self]  in
//            let login = self?.rootView.loginTextField.text!
//            let password = self?.rootView.passwordTextField.text!
//
//            if(!login!.isEmpty && !password!.isEmpty) {
//                Auth.auth().signIn(withEmail: login!, password: password!) { result, error in
//                    if error == nil {
//                            self?.didAuthClosure?()
//                    } else {
//                        self?.showAlert()
//                    }
//                }
//            } else {
//                self?.showAlert()
//            }
//        }).disposed(by: disposeBag)
//
//        goToRegButton.rx.tap.subscribe(onNext: { [weak self]  in
//            self?.didSendEventClosure?()
//        }).disposed(by: disposeBag)
//    }
//
//    deinit {
//        print("AuthorizationViewController deinit")
//    }
//
//    func showAlert() {
//        let alert = UIAlertController(title: "Error", message: "Invalid data", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//extension AuthorizationViewController {
//    enum Event {
//        case login
//    }
//}
