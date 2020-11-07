//
//  ViewController.swift
//  BountyListPractice
//
//  Created by isChoi on 2020/10/26.
//
// MVVM 으로 분리 했음
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = BountyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 연결한 세그웨이로 정보를 넘겨준다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as? DetailViewController
            if let index = sender as? Int {

                let bountyInfo = viewModel.bountyInfo(at: index)
                detailVC?.viewModel.update(model: bountyInfo)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(model: bountyInfo)
        
        return cell
    }
    
    // cell 이 click 되었을 때 호출되는 메소드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(model: BountyInfo) {
        imgView.image = model.image
        nameLabel.text = model.name
        bountyLabel.text = "\(model.bounty)"
    }
}

// Model
struct BountyInfo {
    var name: String
    var bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}

// ViewModel
class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000),
    ]

    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo{
        return bountyInfoList[index]
    }
}

