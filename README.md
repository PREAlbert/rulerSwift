# FSRuler


[![Platform](https://img.shields.io/cocoapods/p/DOFavoriteButton.svg?style=flat)]
[![License](https://img.shields.io/cocoapods/l/DOFavoriteButton.svg?style=flat)]
![Demo](http://7xrr0e.com1.z0.glb.clouddn.com/ruler2.gif)


## Requirements
* iOS 8.0+
* Swift 3.0

## Installation



#### Manual
Just drag ```FSRulerScrollView.swift``` and ```rulerView.swift``` to your project.

## How to use


#### 2. Create a view
##### ・By coding
```
  let ruler: rulerView = rulerView.init(frame: CGRect.init(x: 20, y: 220, width: 260, height: 140))
        ruler.delegete = self
        ruler.showRulerScrollViewWithCount(200, average: 1, currentValue: 0, smallMode: true)
        self.view.addSubview(ruler)
```





## DEMO
There is a demo project added to this repository, so you can see how it works.


## License
This is exercise with swift 3.0,the principle is learn from the [prettyRuler](https://github.com/AsTryE/PrettyRuler)

This software is released under the MIT License.
