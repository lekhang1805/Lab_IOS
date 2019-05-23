import UIKit

Class ContactCell: UITableViewCell{
    var link: ViewController?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let starButton = UIButton(type: .system)
        starButton.setImage(*, for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

        starButton.tintColor = .red
        starButton.addTarget(seft, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc private func handleMarkAsFavorite(){
        link?.someMethodIWantToCall(cell: self)
    }
}