# UIView自动布局的抗压缩和抗拉伸的理解

以`UILable`为例子：
在默认情况下，我们没有设置各个布局的优先级，那么他就会优先显示左边的`label`，左边的完全显示后剩余的空间都是右边的`label`，如果整个空间宽度都不够左边的`label`的话，那么右边的`label`没有显示的机会了。
如果我们现在的需求是优先显示右边的`label`，左边的`label`内容超出的省略，这时就需要我们调整约束的优先级了。

原理：
* 约束优先级: 在`Autolayout`中每个约束都有一个优先级, 优先级的范围是`1~1000`。创建一个约束，默认的优先级是最高的`1000`
* `Content Hugging Priority`:该优先级表示一个控件抗被拉伸的优先级。优先级越高，越不容易被拉伸，默认是`251`。
* `Content Compression Resistance Priority`:该优先级和上面那个优先级相对应，表示一个控件抗压缩的优先级。优先级越高，越不容易被压缩，默认是`750`。

所以默认情况下两边的`label`的`Content Hugging`和`Content Compression`优先级都是一样的，为了让右边的`label`完全显示，那么我们需要增大右边`label`的抗压缩级，或者减小左边`label`的抗压缩级，总之是得让右边的抗压缩级大于左边的`label`，这样才能让右边的label内容优先显示。

`UIView`中关于`Content Hugging`和`Content Compression Resistance`的方法有：

```
- (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
- (void)setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);

- (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
- (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
```