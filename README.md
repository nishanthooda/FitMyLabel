# FitMyLabel
A swift library that uses binary search to split up long strings into portions that fit any specified label. 

## Installation

### Cocapods

You can use [CocoaPods](http://cocoapods.org/) to install `FitMyLabel` by adding it to your `Podfile`:

```ruby
target 'YourProjectName' do
    pod 'FitMyLabel', '~> 1.0.2'
end
```

### Carthage

You can use [Carthage](https://github.com/Carthage/Carthage) to install `FitMyLabel` by adding it to your `Cartfile`:

```
github "nishanthooda/FitMyLabel" ~> 1.0.2
```

Make sure to add `FitMyLabel.framework` to the "Linked Frameworks and Libraries" section of your target, and include all dependencies in your Carthage framework copying build phase.

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `FitMyLabel` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YourProjectName",
    dependencies: [
        .package(url: "https://github.com/nishanthooda/FitMyLabel.git", from: "1.0.2"),
    ]
)
```
Then run `swift build` when ready.

## Usage

#### Splitting up your string

You can use the `splitToFit` function in the `FitMyLabel` class to split your long string at intervals that perfectly fit any specified label. The function requires you to specify the string you want to split and the label to split it according to. The function will return an ordered array of strings. 

Note: 
- You must specify the frame of the label passed as a parameter into the `splitToFit` function. 
- You may also use autoLayout to layout the label, but must call `setNeedsLayout()` and `layoutIfNeeded()` on your label before calling the `splitToFit` function. 

Sample:

```swift
let mySuperLongString = "Hello welcome to the FitMyLabel repo..."
let dummyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

let mySplitUpString = FitMyLabel.splitToFit(str: mySuperLongString, label: dummyLabel)
```

#### Checking if text on label is truncated

You may also use the the `isTruncated()` function on any label to find out if the text currently dispalyed on the label is being truncated. This function will return a boolean indicating whether or not the text has been truncated.

Sample:

```swift
let dummyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
dummy.text = "Hello welcome to the FitMyLabel repo..."

let isMyDummyLabelTruncated = dummyLabel.isTruncated()
```
