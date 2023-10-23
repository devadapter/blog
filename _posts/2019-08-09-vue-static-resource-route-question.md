---
layout: post
title: vue打包后静态资源路径不正确
date:  2019-08-19
author: apters
toc: true
cover: https://source.unsplash.com/random
tags: ['vue','vue-cli']

---

> vue打包后静态资源路径不正确

<!-- more -->



# vue打包静态资源路径不正确的解决办法

vue项目完成打包上线的时候很多人都会碰到静态资源找不到的问题，常见的有两个



1、js，css路径不对

解决办法：打开config/index.js，将其中的assetsPublicPath值改为’./’

```javascript
build: {
    // Template for index.html
    index: path.resolve(__dirname, '../dist/index.html'),

    // Paths
    assetsRoot: path.resolve(__dirname, '../dist'),
    assetsSubDirectory: 'static',
    assetsPublicPath: './',

    /**
     * Source Maps
     */

    productionSourceMap: true,
    // https://webpack.js.org/configuration/devtool/#production
    devtool: '#source-map',

    // Gzip off by default as many popular static hosts such as
    // Surge or Netlify already gzip all static assets for you.
    // Before setting to `true`, make sure to:
    // npm install --save-dev compression-webpack-plugin
    productionGzip: false,
    productionGzipExtensions: ['js', 'css'],

    // Run the build command with an extra argument to
    // View the bundle analyzer report after build finishes:
    // `npm run build --report`
    // Set to `true` or `false` to always turn it on or off
    bundleAnalyzerReport: process.env.npm_config_report
  }
```

2、css中引用的图片资源找不到

我的login.vue文件中有一段css，其中引用了一个背景图片，是这样写的

```
.login{height:100%;background: url("../assets/login_bg.jpg") no-repeat; background-size: cover;color: white;}
```

“src/assets/”文件夹下有这张图片，打包后路径发生变化这个图片就找不到了，stackoverflow上有一个解决办法，很简单

打开“build/utils.js”，增加一行代码`publicPath: '../../'`即可 

```javascript
// Extract CSS when that option is specified
    // (which is the case during production build)
    if (options.extract) {
      return ExtractTextPlugin.extract({
        use: loaders,
        fallback: 'vue-style-loader',
        //
        publicPath: '../../'
      })
    } else {
      return ['vue-style-loader'].concat(loaders)
    }
  }
```

