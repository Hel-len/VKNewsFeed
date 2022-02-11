//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 25.01.2022.
//

import UIKit

protocol FeedCellLayoutCalculaterProtocol {
    func calculateSizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculaterProtocol {

    private let screenWidth: CGFloat

    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }

    func calculateSizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right

        // MARK: - Work with postLabelFrame
        var postLabelFrame = CGRect(
            origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
            size: CGSize.zero
        )
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)

            postLabelFrame.size = CGSize(width: width, height: height)
        }

        // MARK: - Work with attachmentFrame
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(
            origin: CGPoint(x: Constants.commonInsets.left, y: attachmentTop),
            size: CGSize.zero)
        if let attachment = photoAttachment {
            let ratio = Float(attachment.height) / Float(attachment.width)
            attachmentFrame.size = CGSize(
                width: cardViewWidth - Constants.commonInsets.left - Constants.commonInsets.right,
                height: cardViewWidth * CGFloat(ratio))
        }

        // MARK: - Work with attachmentFrame
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(
            origin: CGPoint(x: Constants.commonInsets.left + Constants.cardInsets.left, y: bottomViewTop),
            size: CGSize(
                width: cardViewWidth - Constants.commonInsets.left - Constants.commonInsets.right,
                height: Constants.bottomViewHeight
            )
        )

        // MARK: - Work with attachmentFrame
        let totalHeight = bottomViewFrame.maxY + Constants.commonInsets.bottom + Constants.cardInsets.bottom

        return Sizes(
            postLabelFrame: postLabelFrame,
            attachmentFrame: attachmentFrame,
            bottomViewFrame: bottomViewFrame,
            totalHeight: totalHeight)
    }
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    static let topViewHeight: CGFloat = 40
    static let bottomViewHeight: CGFloat = 48
    static let postLabelInsets = UIEdgeInsets(top: 4 + Constants.topViewHeight + 4, left: 5, bottom: 4, right: 5)
    static let postLabelFont = UIFont.systemFont(ofSize: 14)
    static let commonInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
}
