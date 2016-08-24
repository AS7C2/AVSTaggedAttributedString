//: Playground - noun: a place where people can play

import Cocoa
import AVSTaggedAttributedString

let likers = "<a><p>Andrew</p>, <p>Ann</p>, <p>John</p> and <x>10</x> others.</a>"
var attributedLikers = likers.avs_attributedStringByAddingAttributes([NSForegroundColorAttributeName: NSColor.grayColor()], toTag: "a")
attributedLikers = attributedLikers.avs_attributedStringByAddingAttributes([NSForegroundColorAttributeName: NSColor.greenColor()], toTag: "p")
attributedLikers = attributedLikers.avs_attributedStringByAddingAttributes([NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue, NSForegroundColorAttributeName: NSColor.blackColor()], toTag: "x")
