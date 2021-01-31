import UIKit

class ImageTableViewCell: UITableViewCell,CellConfigurable {
    
    typealias cellViewModel = ImageTableCellViewModel
     var viewModel: ImageTableCellViewModel?

     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
     }
     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         // Configure the view for the selected state
     }
     
     func configureCellWithModel(_ model: ImageTableCellViewModel) {
         self.viewModel = model
         //
        self.incomingImage(with: viewModel?.newsModel.urlToImage ?? "")
     }
   
    private let newstImgView: UIImageView = {
         let imgView = UIImageView()
         imgView.backgroundColor = .clear
         imgView.contentMode = .scaleAspectFill
         imgView.clipsToBounds = true
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
    }()
    private func incomingImage(with imgUrl: String)  {
          for subview in contentView.subviews {
              subview.removeFromSuperview()
          }

          contentView.addSubview(newstImgView)
    
          //newstImgView
          newstImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
          newstImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
          newstImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
          newstImgView.heightAnchor.constraint(equalToConstant: 290).isActive = true
          self.layoutIfNeeded()
            if let url = URL(string: imgUrl){
               // use dispach queue to download image
                self.newstImgView.image = nil
                self.newstImgView.sd_setImage(with: url , placeholderImage: UIImage(named:"Placeholder"))
            }
        }
    
}
