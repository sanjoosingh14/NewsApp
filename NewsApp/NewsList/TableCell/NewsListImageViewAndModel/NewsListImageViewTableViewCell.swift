//
//  NewsListImageTypeTableViewCell.swift
//  NewsApp
//
//  Created by Miraah on 30/01/21.
//  Copyright © 2021 Self. All rights reserved.
//

import UIKit
import SDWebImage

class NewsListImageViewTableViewCell: UITableViewCell, CellConfigurable{
    typealias cellViewModel = NewsListImageViewModel
    var viewModel: NewsListImageViewModel?
    weak var delegate: cellActionDelegate?
    private var tapGesture: UITapGestureRecognizer?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCellWithModel(_ model: NewsListImageViewModel) {
        self.viewModel = model
        //
        self.incomingImage(with: model.newsModel.urlToImage ?? "")
       
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap))
        if let tap = tapGesture{
            contentView.addGestureRecognizer(tap)
        }
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
    
   private func incomingImage(with imgUrl: String)  {
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
        newsDescription.text = self.viewModel?.newsModel.description
        newsAuthor.text = self.viewModel?.newsModel.author
        newsTitle.text = self.viewModel?.newsModel.title

        if let url = URL(string: imgUrl){
           // use dispach queue to download image
           self.newstImgView.image = nil
            self.newstImgView.sd_setImage(with: url , placeholderImage: UIImage(named:"Placeholder"))
        
        }
     
    }
    @objc func normalTap(_ sender: UIGestureRecognizer){
         if let viewM = self.viewModel {
            self.delegate?.clickAction(with: .image, and: viewM.newsModel)
         }
     }
}
