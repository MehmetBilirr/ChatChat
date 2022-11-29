//
//  Media.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 29.11.2022.
//

import Foundation
import MessageKit

struct Media:MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
