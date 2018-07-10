const path = require('path')
const nodeModules = path.join(__dirname, 'node_modules')
const revelryComponents = path.join(nodeModules, 'harmonium', 'lib')
require('babel-polyfill')

require('babel-register')({
  ignore: (filename) => {
    if (filename.indexOf(revelryComponents) === 0) {
      return false
    }
    if (filename.indexOf('node_modules/') >= 0) {
      return true
    }
    return false
  },
})

const {JSDOM} = require('jsdom')

const exposedProperties = ['window', 'navigator', 'document']

const {window} = new JSDOM('')
const {document} = window
Object.keys(document.defaultView).forEach((property) => {
  if (typeof global[property] === 'undefined') {
    exposedProperties.push(property)
    global[property] = document.defaultView[property]
  }
})

global.$ = require('jquery')

global.navigator = {
  userAgent: 'node.js',
}

const documentRef = document

const chai = require('chai')
const chaiAsPromised = require('chai-as-promised')
const enzyme = require('enzyme')
const sinon = require('sinon')
const fetchMock = require('fetch-mock')
const Adapter = require('enzyme-adapter-react-16')

enzyme.configure({adapter: new Adapter()})

chai.use(chaiAsPromised)
global.expect = chai.expect
global.shallow = enzyme.shallow
global.mount = enzyme.mount
global.render = enzyme.render
global.FormData = window.FormData
global.fetchMock = fetchMock
global.sinon = sinon
