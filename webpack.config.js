'use strict';

const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

// Build-time settings (environment variables).
const env = {
  HEBORN_API_HTTP_URL: process.env.HEBORN_API_HTTP_URL || 'https://localhost:4000/v1',
  HEBORN_API_WEBSOCKET_URL: process.env.HEBORN_API_WEBSOCKET_URL || 'wss://localhost:4000/websocket',
  HEBORN_VERSION: process.env.HEBORN_VERSION || 'dev',
  HEBORN_GAME_MODE: process.env.HEBORN_GAME_MODE || 'HE1',
  // Reverse geocoding for in-game locations (Nominatim-compatible API).
  HEBORN_GEOCODER_URL: process.env.HEBORN_GEOCODER_URL || 'https://nominatim.openstreetmap.org/reverse',
  HEBORN_MAP_TILES_URL: process.env.HEBORN_MAP_TILES_URL || 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
};

function origin(url) {
  const u = new URL(url.replace(/\{[a-z]\}/g, 'x'));
  return `${u.protocol}//${u.host}`;
}

function contentSecurityPolicy(production) {
  return [
    "default-src 'self'",
    // webpack's development build and Elm's --debug mode need eval.
    production ? "script-src 'self'" : "script-src 'self' 'unsafe-eval'",
    // Elm views, elm-css and Leaflet set inline styles.
    "style-src 'self' 'unsafe-inline'",
    // desktop wallpaper (src/OS/Style.elm, src/Landing/Style.elm) and map tiles
    `img-src 'self' data: blob: https://raw.githubusercontent.com ${origin(env.HEBORN_MAP_TILES_URL)}`,
    "font-src 'self' data:",
    "media-src 'self' https://archive.org https://*.archive.org",
    `connect-src 'self' ${origin(env.HEBORN_API_HTTP_URL)} ${origin(env.HEBORN_API_WEBSOCKET_URL)} ${origin(env.HEBORN_GEOCODER_URL)}`,
    "object-src 'none'",
    "base-uri 'self'",
    "form-action 'self'",
  ].join('; ');
}

module.exports = (_env, argv) => {
  const production = argv.mode === 'production';

  return {
    mode: production ? 'production' : 'development',
    // No eval-based source maps, so the production CSP can forbid eval.
    devtool: production ? 'source-map' : 'cheap-module-source-map',

    entry: {
      app: path.join(__dirname, 'static/js/index.js'),
    },

    output: {
      path: path.join(__dirname, 'build'),
      filename: production ? 'js/[name]-[contenthash].js' : 'js/[name]-dev.js',
      publicPath: '',
      clean: true,
    },

    resolve: {
      extensions: ['.js', '.elm'],
      alias: {
        leaflet_css: path.join(__dirname, 'node_modules/leaflet/dist/leaflet.css'),
        leaflet_js: path.join(__dirname, 'node_modules/leaflet/dist/leaflet.js'),
        leaflet_ant_js: path.join(__dirname, 'node_modules/leaflet-ant-path/dist/leaflet-ant-path.js'),
      },
    },

    module: {
      noParse: /\.elm$/,
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: path.join(__dirname, 'tools/elm-loader.js'),
            options: { debug: !production, warn: !production },
          },
        },
        {
          test: /\.css$/,
          use: [
            // extracted CSS lives in css/, so asset URLs must go one level up
            production ? { loader: MiniCssExtractPlugin.loader, options: { publicPath: '../' } } : 'style-loader',
            'css-loader',
            'postcss-loader',
          ],
        },
        {
          test: /\.(woff2?|ttf|eot|otf)(\?.*)?$/,
          type: 'asset/resource',
          generator: { filename: 'fonts/[name]-[contenthash][ext]' },
        },
        {
          test: /\.svg(\?.*)?$/,
          type: 'asset',
          parser: { dataUrlCondition: { maxSize: 50000 } },
          generator: { filename: 'images/[name]-[contenthash][ext]' },
        },
        {
          test: /\.(png|jpe?g|gif)$/,
          type: 'asset/resource',
          generator: { filename: 'images/[name]-[contenthash][ext]' },
        },
      ],
    },

    plugins: [
      new CopyWebpackPlugin({
        patterns: [
          { from: 'static/img/', to: 'images/', globOptions: { ignore: ['**/README.md'] } },
          { from: 'static/favicon.ico', to: 'favicon.ico' },
        ],
      }),
      new HtmlWebpackPlugin({
        template: 'static/index.html',
        inject: 'body',
        templateParameters: { csp: contentSecurityPolicy(production) },
      }),
      new webpack.EnvironmentPlugin(env),
      production && new MiniCssExtractPlugin({ filename: 'css/[name]-[contenthash].css' }),
    ].filter(Boolean),

    devServer: {
      static: false,
      historyApiFallback: true,
      port: Number(process.env.PORT || 8000),
      hot: false,
      liveReload: true,
      client: { overlay: { warnings: false, errors: true } },
    },

    performance: { hints: false },
  };
};
