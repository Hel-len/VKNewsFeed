//
//  String + Height.swift
//  VKNewsFeed
//
//  Created by Елена Дранкина on 25.01.2022.
//

import UIKit

extension String {

    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil)
        return ceil(size.height)
    }
}
