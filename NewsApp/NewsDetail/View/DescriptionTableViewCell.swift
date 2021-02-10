
import UIKit

class DescriptionTableViewCell: UITableViewCell,CellConfigurable {
    
    typealias cellViewModel = DescriptionTablleCellViewModel
     var viewModel: DescriptionTablleCellViewModel?

     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }
    
    private let newsTitle: UILabel = {
       let label =  UILabel()
       label.numberOfLines = 0
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 18)
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       return label
    }()
    
    private let newsDescription: UILabel = {
       let label =  UILabel()
       label.numberOfLines = 0
       label.textColor = .darkGray
       label.font = UIFont.boldSystemFont(ofSize: 16)
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       return label
    }()
    
     func configureCellWithModel(_ model: DescriptionTablleCellViewModel) {
         self.viewModel = model
         self.setupViews()
         newsDescription.text = self.viewModel?.newsModel.description
         newsTitle.text = self.viewModel?.newsModel.title

    }
   
     func setupViews(){
            for subview in contentView.subviews {
                subview.removeFromSuperview()
            }

            contentView.addSubview(newsTitle)
            contentView.addSubview(newsDescription)

              //title
              newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
              newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
              newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
              //description
              newsDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
              newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10).isActive = true
              newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
              self.layoutIfNeeded()
        
     }
}
