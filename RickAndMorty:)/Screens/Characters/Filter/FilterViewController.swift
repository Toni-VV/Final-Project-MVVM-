import UIKit

protocol FilterViewContollerDelegate: AnyObject {
    func sendDelegateItems(gender: String,
                           status: String)
}

class FilterViewController: UIViewController {
    
   
    
    //MARK: - Properties
    
    weak var delegate: FilterViewContollerDelegate?
    
    var gender: String!
    var status: String!
    
    //labels
    private let aliveLabel = UILabel(text: "Alive",font: 20)
    private let deadLabel = UILabel(text: "Dead",font: 20)
    private let unknownLabel = UILabel(text: "Unknown",font: 20)
    private let femaleLabel = UILabel(text: "Female",font: 20)
    private let maleLabel = UILabel(text: "Male",font: 20)
    private let genderlessLabel = UILabel(text: "Genderless",font: 20)
    private let unknownLabel2 = UILabel(text: "Unknown",font: 20 )
    private let statusLabel = UILabel(text: "Status",
                                      textColor: UIColor.titleColor(), font: 25)
    private let genderLabel = UILabel(text: "Gender",
                                      textColor: UIColor.titleColor(),font: 25)
    //buttons
    private let resetButton1 = UIButton(textColor: .systemRed)
    private let resetButton2 = UIButton(textColor: .systemRed)
    private let aliveButton = UIButton(tintColor: .white, tag: 1)
    private let deadButton = UIButton(tintColor: .white, tag: 2)
    private let unknownButton = UIButton(tintColor: .white, tag: 3)
    private let femaleButton = UIButton(tintColor: .white, tag: 4)
    private let maleButton = UIButton(tintColor: .white, tag: 5)
    private let genderlessButton = UIButton(tintColor: .white, tag: 6)
    private let unknownbutton2 = UIButton(tintColor: .white, tag: 7)
    private let applyFilterButton = UIButton(text: "Apply filters",
                                             color: UIColor.titleColor(),
                                             aligment: .center,
                                             borderColor: UIColor.titleColor().cgColor,
                                             font: 25,
                                             borderWidth: 1,
                                             cornerRadius: 20)
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        setupNavigationBar(name: "Filter",
                           action: #selector(didTapBackButton))
        setupView()
        buttonsActions()
    }
    
    //MARK: - Setup UI
    private func setupView() {
        
        let statusAndResetStack = configStatusAndResetStack(label: statusLabel,
                                                            button: resetButton1)
        view.addSubview(statusAndResetStack)
        statusAndResetStack.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                       left: view.leftAnchor,
                                       right: view.rightAnchor,
                                       topConstant: 30,
                                       leftConstant: 20,
                                       rightConstant: 20,
                                       heightConstant: 50)
        
        let statusButtonsAndLabelsStack = configButtonsAndLabelsStack(buttons: [aliveButton,deadButton,unknownButton],
                                                             labels: [aliveLabel,deadLabel,unknownLabel])
        view.addSubview(statusButtonsAndLabelsStack)
        statusButtonsAndLabelsStack.constraint(top: statusAndResetStack.bottomAnchor,
                                      left: view.leftAnchor,
                                      topConstant: 20,
                                      leftConstant: 20)
        
        let genderAndResetStack = configStatusAndResetStack(label: genderLabel,
                                                            button: resetButton2)
        view.addSubview(genderAndResetStack)
        genderAndResetStack.constraint(top: statusButtonsAndLabelsStack.bottomAnchor,
                                       left: view.leftAnchor,
                                       right: view.rightAnchor,
                                       topConstant: 30,
                                       leftConstant: 20,
                                       rightConstant: 20,
                                       heightConstant: 50)
        
        let genderButtonsAndLabelsStack = configButtonsAndLabelsStack(buttons: [femaleButton,maleButton,genderlessButton,unknownbutton2],
                                                             labels: [femaleLabel,maleLabel,genderlessLabel,unknownLabel2])
        view.addSubview(genderButtonsAndLabelsStack)
        genderButtonsAndLabelsStack.constraint(top: genderAndResetStack.bottomAnchor,
                                      left: view.leftAnchor,
                                      topConstant: 20,
                                      leftConstant: 20)
        view.addSubview(applyFilterButton)
        applyFilterButton.constraint(left: view.leftAnchor,
                                     right: view.rightAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     leftConstant: 20,
                                     bottomConstant: 20,
                                     rightConstant: 20,
                                     heightConstant: 50)
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Logic
extension FilterViewController {
    
    private func buttonsActions() {
        aliveButton.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        deadButton.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        unknownButton.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        
        femaleButton.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        genderlessButton.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        unknownbutton2.addTarget(self, action: #selector(didTapGenderButton), for: .touchUpInside)
        
        resetButton1.addTarget(status, action: #selector(didTapResetButton1), for: .touchUpInside)
        resetButton2.addTarget(status, action: #selector(didTapResetButton2), for: .touchUpInside)
        
        applyFilterButton.addTarget(self, action: #selector(didTapApplyFilterButton), for: .touchUpInside)
    }
   
    @objc private func didTapStatusButton(buttons: UIButton) {
        let color = UIColor.titleColor()
        switch buttons.tag {
        case 1:
            aliveButton.tintColor = color
            deadButton.tintColor = .white
            unknownButton.tintColor = .white
            
            aliveLabel.textColor = color
            deadLabel.textColor = .white
            unknownLabel.textColor = .white
            
            resetButton1.alpha = 1
            status = aliveLabel.text
        case 2:
            aliveButton.tintColor = .white
            deadButton.tintColor = color
            unknownButton.tintColor = .white
            
            aliveLabel.textColor = .white
            deadLabel.textColor = color
            unknownLabel.textColor = .white
            
            resetButton1.alpha = 1
            status = deadLabel.text
        case 3:
            aliveButton.tintColor = .white
            deadButton.tintColor = .white
            unknownButton.tintColor = color
            
            aliveLabel.textColor = .white
            deadLabel.textColor = .white
            unknownLabel.textColor = color
            
            resetButton1.alpha = 1
            status = unknownLabel.text
        default:
            break
        }
    }
    
    @objc private func didTapGenderButton(buttons: UIButton) {
        let color = UIColor.titleColor()
        switch buttons.tag {
        case 4:
            femaleButton.tintColor = color
            maleButton.tintColor = .white
            genderlessButton.tintColor = .white
            unknownbutton2.tintColor = .white
            
            femaleLabel.textColor = color
            maleLabel.textColor = .white
            genderlessLabel.textColor = .white
            unknownLabel2.textColor = .white
            
            resetButton2.alpha = 1
            gender = femaleLabel.text
        case 5:
            femaleButton.tintColor = .white
            maleButton.tintColor = color
            genderlessButton.tintColor = .white
            unknownbutton2.tintColor = .white
            
            femaleLabel.textColor = .white
            maleLabel.textColor = color
            genderlessLabel.textColor = .white
            unknownLabel2.textColor = .white
            
            resetButton2.alpha = 1
            gender = maleLabel.text
        case 6:
            femaleButton.tintColor = .white
            maleButton.tintColor = .white
            genderlessButton.tintColor = color
            unknownbutton2.tintColor = .white
            
            femaleLabel.textColor = .white
            maleLabel.textColor = .white
            genderlessLabel.textColor = color
            unknownLabel2.textColor = .white
            
            resetButton2.alpha = 1
            gender = genderlessLabel.text
        case 7:
            femaleButton.tintColor = .white
            maleButton.tintColor = .white
            genderlessButton.tintColor = .white
            unknownbutton2.tintColor = color
            
            femaleLabel.textColor = .white
            maleLabel.textColor = .white
            genderlessLabel.textColor = .white
            unknownLabel2.textColor = color
            
            resetButton2.alpha = 1
            gender = unknownLabel2.text
        default:
            break
        }
    }
    
    @objc private func didTapResetButton1() {
        resetButton1.alpha = 0.3
        aliveButton.tintColor = .white
        deadButton.tintColor = .white
        unknownButton.tintColor = .white
        
        aliveLabel.textColor = .white
        deadLabel.textColor = .white
        unknownLabel.textColor = .white
        
        status = ""
    }
    
    @objc private func didTapResetButton2() {
        resetButton2.alpha = 0.3
        femaleButton.tintColor = .white
        maleButton.tintColor = .white
        genderlessButton.tintColor = .white
        unknownbutton2.tintColor = .white
        
        femaleLabel.textColor = .white
        maleLabel.textColor = .white
        genderlessLabel.textColor = .white
        unknownLabel2.textColor = .white
        
        gender = ""
    }
    
    @objc private func didTapApplyFilterButton() {
        if  gender == nil {
            gender = ""
        }
        if  status == nil {
            status = ""
        }
        guard gender != "" || status != ""
        else
        {
            showAlert(with: "NO FILTERS SELECTED",
                      and: "Please choose anyone")
            return
        }
        delegate?.sendDelegateItems(gender: gender!,
                                    status: status!)
        navigationController?.popViewController(animated: true)
    }
}
