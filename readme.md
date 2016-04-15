# Texatar

A server that generates images with text to replace default gravatar image.

The problem we face is not everyone has a gravatar image linked to their email address.  When we show images in place of names, they all look the same and there is no way to differentiate between people.  Texatar will generate an image based on text for the user.  The color scheme is equally important and is based on a hash of the user's email.

## Usage

Images are generate from https://texatar.jabwire.com/:size/:text.png

The following parameters used to control the generated image:

* :text = the text to display in the texatar
* :size = the size of the image in pixels

For example, the link, https://texatar.jabwire.com/200/ds.png, would create a 200 x 200 image with the text ds in the center.

![Texatar](https://texatar.jabwire.com/200/ds.png)

## Gravatar Integration

Gravatar allows developers to supply their own default image with the d= or default= parameter.  Be sure to URL encode the parameter's value.

```
<img src="https://www.gravatar.com/avatar/00000000000000000000000000000000?d=https%3A%2F%2Ftexatar.jabwire.com%2F200%f2ds.png">
```

See https://en.gravatar.com/site/implement/images/#default-image for more information.

# Contact Information

You can find me on Twitter: @dshimy or via gmail.

# License

MIT License

Copyright (c) 2013-2016 Darian Shimy

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

