// Netlify serverless function
process.env.NODE_ENV = 'production';

// Ensure all necessary packages are available
const path = require('path');
const fs = require('fs');

// Add multiple search paths for modules
const searchPaths = [
  path.join(__dirname, 'node_modules'),
  path.join(__dirname, '../../node_modules'),
  path.join(__dirname, '../../backend/node_modules'),
  '/opt/nodejs/node_modules'
];

// Set NODE_PATH
process.env.NODE_PATH = searchPaths.filter(p => {
  try {
    return fs.existsSync(p);
  } catch (e) {
    return false;
  }
}).join(path.delimiter);

require('module').Module._initPaths();

// Preload critical packages to ensure they're available
try {
  require('pg');
  require('sequelize');
  require('bcryptjs');
} catch (e) {
  console.error('Failed to preload packages:', e.message);
}

// Load environment variables
require('dotenv').config({ path: path.join(__dirname, '../../.env.local') });
require('dotenv').config({ path: path.join(__dirname, '../../.env') });

console.log('Node paths:', process.env.NODE_PATH);
console.log('Environment DATABASE_URL set:', !!process.env.DATABASE_URL);
console.log('Environment JWT_SECRET set:', !!process.env.JWT_SECRET);

const serverless = require('serverless-http');
const app = require('../../backend/server');

// Custom request handler to ensure body parsing works
const handler = serverless(app, {
  binary: ['application/octet-stream', 'image/*']
});

exports.handler = async (event, context) => {
  // Check if this is actually an API request
  const path = event.rawPath || event.path || '';
  
  // Log the request for debugging
  console.log(`Function called: path="${path}", method="${event.httpMethod}"`);
  
  // Only process /api/* routes
  if (!path.startsWith('/api/') && path !== '/api') {
    console.log(`Path does not start with /api/, passing through. Path: ${path}`);
    // Return a response that won't interfere with Netlify redirects
    // Returning an error might cause Netlify to try other routes
    return {
      statusCode: 404,
      headers: {
        'Content-Type': 'text/plain'
      },
      body: 'Not Found'
    };
  }

  // If this is an OPTIONS request, handle CORS
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type,Authorization'
      }
    };
  }
  
  // Call the serverless handler for API routes
  console.log(`Processing API request: ${path}`);
  return handler(event, context);
};