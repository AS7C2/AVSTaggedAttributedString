//
//  AVSTaggedAttributedString.swift
//  AVSTaggedAttributedString
//
//  Created by Andrei Sherstniuk on 8/8/16.
//
//

import Foundation

extension NSMutableAttributedString {
    func avs_addAttributes(attributes: [String: AnyObject], tag: String) {
        let openTag = "<\(tag)>"
        let closeTag = "</\(tag)>"
        var string = self.mutableString
        var openRange = string.rangeOfString(openTag)
        var closeRange = string.rangeOfString(closeTag)
        while openRange.location != NSNotFound && closeRange.location != NSNotFound && openRange.location + openRange.length <= closeRange.location {
            var innerLocation = openRange.location + openRange.length
            let innerLength = closeRange.location - openRange.location - openRange.length
            innerLocation -= openRange.length;

            self.replaceCharactersInRange(closeRange, withString: "")
            self.replaceCharactersInRange(openRange, withString: "")

            let innerRange = NSRange(location: innerLocation, length: innerLength)
            self.addAttributes(attributes, range: innerRange)

            string = self.mutableString
            openRange = string.rangeOfString(openTag)
            closeRange = string.rangeOfString(closeTag)
        }
    }
}