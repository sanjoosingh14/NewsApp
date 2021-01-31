import UIKit

class AdditionalInfoTableViewCell: UITableViewCell,CellConfigurable {
    
    typealias cellViewModel = AditionalInfoTableCellViewModel
     var viewModel: AditionalInfoTableCellViewModel?

     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }
     
     func configureCellWithModel(_ model: AditionalInfoTableCellViewModel) {
         self.viewModel = model
         //
        self.setupViews()
     }
    private let newsLike: UILabel = {
       let label =  UILabel()
       label.numberOfLines = 1
       label.textColor = .gray
       label.font = UIFont.systemFont(ofSize: 14)
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       return label
    }()
    
    private let newsComment: UILabel = {
       let label =  UILabel()
       label.numberOfLines = 1
       label.textColor = .gray
       label.font = UIFont.systemFont(ofSize: 14)
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       return label
    }()
    func setupViews(){
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }

        contentView.addSubview(newsLike)
        contentView.addSubview(newsComment)
        //title
      newsLike.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
      newsLike.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
      //description
      newsComment.leadingAnchor.constraint(equalTo: newsLike.trailingAnchor, constant: 10).isActive = true
      newsComment.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
      self.layoutIfNeeded()
        
      newsLike.text = "Like: \(self.viewModel?.newsModel.like ?? 0)"
      newsComment.text =  "Comment: \(self.viewModel?.newsModel.comment ?? 0)"
     }
}
