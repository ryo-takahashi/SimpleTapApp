import UIKit

class CallBackViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    
    let viewModel = CallBackViewModel()

    @IBAction func countUp(_ sender: Any) {
        viewModel.incrementCount(callback: { [weak self] count in
            self?.updateLabel(count: count)
        })
    }
    
    @IBAction func countDown(_ sender: Any) {
        viewModel.decrementCount(callback: { [weak self] count in
            self?.updateLabel(count: count)
        })
    }
    
    private func updateLabel(count: Int) {
        countLabel.text = "標準パターン: \(count)"
    }
}

class CallBackViewModel {
    var count = 0

    func incrementCount(callback: (Int) -> ()) {
        count += 1
        callback(count)
    }

    func decrementCount(callback: (Int) -> ()) {
        count -= 1
        callback(count)
    }
}
