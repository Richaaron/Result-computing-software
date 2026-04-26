#!/bin/bash
set -e

echo "Installing root dependencies..."
npm install --legacy-peer-deps

echo "Installing backend dependencies..."
npm --prefix backend install --legacy-peer-deps

echo "Installing frontend dependencies..."
npm --prefix frontend-react install --legacy-peer-deps

echo "Building frontend..."
npm --prefix frontend-react run build

echo "Build complete!"
