import UIKit

class ImageTableViewCell: UITableViewCell,CellConfigurable {
    
    typealias cellViewModel = ImageTableCellViewModel
     var viewModel: ImageTableCellViewModel?
    
     func configureCellWithModel(_ model: ImageTableCellViewModel) {
        self.viewModel = model
        self.newstImgView.image = viewModel?.image.value
        setupBinding()
     }
   
    private let newstImgView: UIImageView = {
         let imgView = UIImageView()
         imgView.backgroundColor = .clear
         imgView.contentMode = .scaleAspectFill
         imgView.clipsToBounds = true
         imgView.translatesAutoresizingMaskIntoConstraints = false
         return imgView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         addConstraintsOnViews()
    }
     
    private func setupBinding() {
          viewModel?.image.addObserver({ [weak self] (img) in
              DispatchQueue.main.async {
                  self?.newstImgView.image = img
              }
              
          })
      }
    private func addConstraintsOnViews() {
        for subview in contentView.subviews {
                  subview.removeFromSuperview()
              }

              contentView.addSubview(newstImgView)
               newstImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
              newstImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
              newstImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
              newstImgView.heightAnchor.constraint(equalToConstant: 290).isActive = true
              self.layoutIfNeeded()
        
    }
    
}
