// Netlify serverless function
process.env.NODE_ENV = 'production';

// Set NODE_PATH to include all node_modules so backend can find dependencies
const path = require('path');
const nodePaths = [
  path.join(__dirname, 'node_modules'),
  path.join(__dirname, '../../node_modules'),
  path.join(__dirname, '../../backend/node_modules'),
].filter(p => require('fs').existsSync(p));

process.env.NODE_PATH = nodePaths.join(path.delimiter);
require('module').Module._initPaths();

// Load environment variables from .env file in development
// In Netlify, use dashboard to set environment variables
require('dotenv').config({ path: path.join(__dirname, '../../.env.local') });
require('dotenv').config({ path: path.join(__dirname, '../../.env') });

const serverless = require('serverless-http');
const app = require('../../backend/server');

exports.handler = serverless(app);