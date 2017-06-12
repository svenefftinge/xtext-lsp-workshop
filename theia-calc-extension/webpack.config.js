const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const monacoFromPath = path.join(__dirname, 'node_modules', 'monaco-editor-core', 'dev', 'vs');
const monacoToPath = path.join(__dirname, 'lib', 'frontend', 'vs');

module.exports = {

    target: 'web',

    devtool: 'source-map',

    entry: path.join(__dirname, 'src', 'frontend', 'index.ts'),

    output: {
        filename: 'bundle.js',
        path: path.join(__dirname, 'lib', 'frontend')
    },

    resolve: {
        extensions: ['.ts', '.js']
    },

    module: {
        rules: [
            {
                test: /\.tsx?$/,
                loader: 'ts-loader',
                exclude: [
                path.join(__dirname, 'node_modules')
            ],
            },
            {
                test: /\.css$/,
                loader: 'style-loader!css-loader'
            },
            {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
                loader: 'url-loader?limit=10000&mimetype=image/svg+xml'
            },
            {
                test: /\.js$/,
                enforce: 'pre',
                loader: 'source-map-loader'
            }
        ],
        noParse: /vscode-languageserver-types|vscode-uri/
    },

    node: {
        fs: 'empty',
        net: 'empty'
    },

    stats: {
        colors: true,
        warnings: false,
        errorDetails: true
    },

    devServer: {
        proxy: {
            '/filesystem/*': {
                target: 'ws://localhost:3000',
                ws: true
            },
            '/languages/*': {
                target: 'ws://localhost:3000',
                ws: true
            },
            '/terminals/*': {
                target: 'ws://localhost:3000',
                ws: true
            },
            '*': 'http://localhost:3000'
        },
        historyApiFallback: true,
        hot: true,
        inline: true,
        host: process.env.HOST || '127.0.0.1',
        port: process.env.PORT
    },

    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new CopyWebpackPlugin([
            {
                from: monacoFromPath,
                to: monacoToPath
            }
        ])
    ]

}