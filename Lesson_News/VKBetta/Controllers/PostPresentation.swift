//
//  File.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//


import UIKit

struct PostPresentation {
    let totalHeight: CGFloat
    let textHeight: CGFloat
    let totalPhotosHeight: CGFloat
    let imageUrl: String?
    let author: String
    let date: String
    let likes: String
    let reposts: String
    let comments: String
    let views: String
    let text: NSAttributedString?
    let photos: [PhotoNews]
    
    var isCompact = false
    
    private let photoHeight = (UIScreen.main.bounds.size.width - 12) * 2 / 3
    private let photoGalleryBarHeight: CGFloat = 40
    private let maxWidth = UIScreen.main.bounds.size.width - 40
    private let compactTextHeight: CGFloat = 130
    private let compactTextLimit: CGFloat = 170
    private let limitAddHeight: CGFloat = 23

    init(with post: Post) {
        
        func prepareAuthor() -> String {
            if let problem = post.user?.problem ?? post.group?.problem {
                return problem.rawValue
            } else if let user = post.user {
                if let firstName = user.firstName, let lastName = user.lastName {
                    return "\(firstName) \(lastName)"
                } else if let firstName = user.firstName {
                    return firstName
                } else if let lastName = user.lastName {
                    return lastName
                } else {
                    return ""
                }
            } else if let group = post.group {
                return group.name
            } else {
                return ""
            }
        }
        
        func prepareDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM в HH:mm"
            formatter.locale = Locale(identifier: "ru")
            return formatter.string(from: post.date)
        }
        
        func prepareViews() -> String {
            let count = post.views
            if count < 1000 {
                return "\(post.views)"
            } else if count < 10000 {
                return String(format: "%.1fK", Float(count) / 1000)
            } else {
                return String(format: "%.0fK", floorf(Float(count) / 1000))
            }
        }
        
        author = prepareAuthor()
        date = prepareDate()
        imageUrl = post.user?.photoUrl ?? post.group?.photoUrl
        likes = "\(post.likes)"
        reposts = "\(post.reposts)"
        comments = "\(post.comments)"
        views = prepareViews()
        
        if let text = post.text, text.count > 0 {
            let attributedString = NSMutableAttributedString(string: text)
            let range = NSMakeRange(0, attributedString.string.count - 1)
            if let font = UIFont(name: "SFProText-Regular", size: 15) {
                attributedString.addAttributes([NSAttributedString.Key.font: font], range: range)
            }
            attributedString.addAttributes([NSAttributedString.Key.kern: -0.17], range: range)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineSpacing = 4
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
            
            let size = attributedString.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            
            self.text = attributedString
            if size.height >= compactTextLimit {
                isCompact = true
            }
            textHeight = size.height
        } else {
            self.text = nil
            textHeight = 0
        }
        
        photos = post.photos
        let count = post.photos.count
        if count == 1 {
            totalPhotosHeight = photoHeight
        } else if count > 1 {
            totalPhotosHeight = photoHeight + photoGalleryBarHeight
        } else {
            totalPhotosHeight = 0
        }
        
        totalHeight = max(124, 124 + textHeight + totalPhotosHeight)
    }
    
    func compactHeight() -> CGFloat {
        return 124 + compactTextHeight + limitAddHeight + totalPhotosHeight
    }
}
