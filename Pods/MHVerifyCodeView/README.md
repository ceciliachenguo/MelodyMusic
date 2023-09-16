# MHVerifyCodeView

[![CI Status](https://img.shields.io/travis/feaskters/MHVerifyCodeView.svg?style=flat)](https://travis-ci.org/feaskters/MHVerifyCodeView)
[![Version](https://img.shields.io/cocoapods/v/MHVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/MHVerifyCodeView)
[![License](https://img.shields.io/cocoapods/l/MHVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/MHVerifyCodeView)
[![Platform](https://img.shields.io/cocoapods/p/MHVerifyCodeView.svg?style=flat)](https://cocoapods.org/pods/MHVerifyCodeView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![VerifyCodeView](https://s1.ax1x.com/2020/04/30/JqcKXj.gif)

## Requirements

 - iOS >= 9.0
 - swift5

## Installation

MHVerifyCodeView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MHVerifyCodeView'
```

## Usage

```swift
let verifyCodeView = MHVerifyCodeView.init()
verifyCodeView.spacing = 10
verifyCodeView.verifyCount = 4
verifyCodeView.setCompleteHandler { (result) in
      print(result)
}
```

## Author

feaskters, 739296759@qq.com

## License

MHVerifyCodeView is available under the MIT license. See the LICENSE file for more info.
