import UIKit
import RxSwift

class SimpleTapViewController: UIViewController {
    
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.messageLabel.text = "Changed!!"
            })
            .disposed(by: disposeBag)
    }
    
//    @IBAction func buttonTap(_ sender: Any) {
//        messageLabel.text = "Changed!!"
//    }
}
