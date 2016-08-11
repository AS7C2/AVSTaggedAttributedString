//
//  AVSTaggedAttributedString.swift
//  AVSTaggedAttributedString
//
//  Created by Andrei Sherstniuk on 8/8/16.
//
//

import Foundation

extension NSMutableAttributedString {
    func avs_addAttributes(attributes: [String: AnyObject], tag: String, removeTag: Bool) {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        let string = self.mutableString
        let openRange = string.rangeOfString(openTag)
        let closeRange = string.rangeOfString(closeTag)
        if openRange.location != NSNotFound && closeRange.location != NSNotFound {
            var innerLocation = openRange.location + openRange.length
            let innerLength = closeRange.location - openRange.location - openRange.length
            if removeTag {
                innerLocation -= openRange.length;
                self.replaceCharactersInRange(closeRange, withString: "")
                self.replaceCharactersInRange(openRange, withString: "")
            }
            //if innerLength > 0 {
                let innerRange = NSRange(location: innerLocation, length: innerLength)
                self.addAttributes(attributes, range: innerRange)
            //}
        }
    }
}