# Website

The source code for the website https://www.siegfriedweber.net.

## Technology

The code is written in [PureScript](http://www.purescript.org/) and based on the UI library [purescript-halogen](https://github.com/slamdata/purescript-halogen).

## Structure

The file [src/Page.purs](https://github.com/siegfriedweber/website/blob/master/src/Page.purs) contains the page content which is static. The components the page consists of are located in the directory [src/Elements](https://github.com/siegfriedweber/website/tree/master/src/Elements). Each element bundles its markup and its stylesheet. The styles of all elements are collected and rendered in the file [src/Elements.purs](https://github.com/siegfriedweber/website/blob/master/src/Elements.purs). The file [src/Main.purs](https://github.com/siegfriedweber/website/blob/master/src/Main.purs) contains the main function which runs the Halogen framework und renders the page.

## Features

* Responsive web design: layouts for small, medium and large devices
* Support for screen and print
* Localization: According to the detected language the content is shown in English or German.

## Content Security Policy

The website requires at least the following content security policy:

Directive     | Policy
------------- | -----------------
`default-src` | `'none'`
`font-src`    | `'self'`
`img-src`     | `'self' https://www.exali.de/`
`script-src`  | `'self'`
`style-src`   | `'unsafe-inline'`

