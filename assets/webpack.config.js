const path = require('path')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const nodeModulesPath = path.resolve(__dirname, 'node_modules')

// The webpack config
module.exports = {
  devtool: 'source-map',
  entry: {
    app: ['whatwg-fetch', './js/app.js'],
  },
  output: {
    path: path.resolve(__dirname, '..', 'priv', 'static'),
    filename: 'js/[name].js',
  },
  plugins: [
    // Copy all of our assets to the priv/static folder
    new CopyWebpackPlugin([
      {
        from: path.resolve(__dirname, 'static'),
        to: path.resolve(__dirname, '..', 'priv', 'static'),
      },
    ]),
    // Separate the css into it's own file
    new MiniCssExtractPlugin({
      filename: 'css/[name].css',
      chunkFilename: '[id].css',
    }),
  ],
  module: {
    rules: [
      // JS rules
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
      },
      // SCSS rules
      {
        test: /\.scss$/,
        use: [
          MiniCssExtractPlugin.loader,
          {loader: 'css-loader', options: {sourceMap: true}},
          {loader: 'postcss-loader', options: {sourceMap: true}},
          {
            loader: 'resolve-url-loader',
            options: {keepQuery: true, sourceMap: true},
          },
          {
            loader: 'sass-loader',
            options: {
              sourceMap: true,
              includePaths: [nodeModulesPath],
            },
          },
        ],
      },
      // For images and fonts found in our scss files
      {
        test: /\.(jpg|jpeg|gif|png)$/,
        exclude: [nodeModulesPath],
        use: [
          'file-loader',
          {
            loader: 'image-webpack-loader',
            options: {
              bypassOnDebug: true,
            },
          },
        ],
      },
      {
        test: /\.(woff2?|ttf|eot|svg)(\?[a-z0-9\=\.]+)?$/,
        exclude: [nodeModulesPath],
        loader: 'file-loader',
      },
    ],
  },
}
