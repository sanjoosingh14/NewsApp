
import UIKit

class NewsListImageViewTableViewCell: UITableViewCell, CellConfigurable{
   
    typealias cellViewModel = NewsListImageViewModel
    var viewModel: NewsListImageViewModel?
    
    func configureCellWithModel(_ model: NewsListImageViewModel) {
        self.viewModel = model
        self.newstImgView.image = viewModel?.image.value
        self.newsTitle.text = viewModel?.newsModel.title
        newsDescription.text = self.viewModel?.newsModel.description
        newsAuthor.text = self.viewModel?.published
        newsTitle.text = self.viewModel?.newsModel.title
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
       
    private let newsTitle: UILabel = {
       let label =  UILabel()
       label.numberOfLines = 0
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 16)
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textAlignment = .left
       return label
    }()
    private let newsDescription: UILabel = {
        let label =  UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    private let newsAuthor: UILabel = {
        let label =  UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
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
            contentView.addSubview(newsTitle)
            contentView.addSubview(newsDescription)
            contentView.addSubview(newsAuthor)
            
            //newstImgView
            newstImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
            newstImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            newstImgView.widthAnchor.constraint(equalToConstant: 130).isActive = true
            newstImgView.heightAnchor.constraint(equalToConstant: 130).isActive = true
            self.layoutIfNeeded()
            
            //author
            newsAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
            newsAuthor.topAnchor.constraint(equalTo: newstImgView.bottomAnchor, constant: 10).isActive = true
            //title
            newsTitle.leadingAnchor.constraint(equalTo: newstImgView.trailingAnchor, constant: 10).isActive = true
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
            newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
            newsTitle.numberOfLines = 2
        
            //description
            newsDescription.leadingAnchor.constraint(equalTo: newstImgView.trailingAnchor, constant: 10).isActive = true
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 5).isActive = true
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
            newsDescription.numberOfLines = 4
            self.layoutIfNeeded()
     }
 
}
