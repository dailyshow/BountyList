//
//  ViewController.swift
//  BountyListPractice
//
//  Created by isChoi on 2020/10/26.
//
// MVVM 으로 분리 했음
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    // UICollectionViewDataSource
    // 몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        // collectionView 에서는 item 순서를 인식해야 하기 때문에 indexPath.row가 아니라 indexPath.item 을 사용한다.
        cell.update(model: bountyInfo)
        
        return cell
    }
    
    
    // UICollectionViewDelegate
    // 셀이 클릭되었을 때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        //
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    // UICollectionViewDelegateFlowLayout
    // 셀 사이즈를 계산할거다. collectionViewCell 한개의 크기가 단말기 한 줄에 2개 이상 보여주기 어렵다고 판단되면 하나만 보여주기도 하기 때문에 커스텀 크기 조절을 해주도록 한다.
    // 다양한 크기의 디바이스에 대응하기 위해서는 크기 조절이 필수이다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
}

// collectionView 로 변경하고 나서 추가한 내용
class GridCell: UICollectionViewCell {

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

