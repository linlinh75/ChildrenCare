import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

const root = ReactDOM.createRoot(document.getElementById('root'));

// Add this function to adjust iframe height
function sendHeight() {
  if (window.parent) {
    window.parent.postMessage({
      type: 'setHeight',
      height: document.documentElement.scrollHeight
    }, '*');
  }
}

root.render(
  <React.StrictMode>
    <App onLoad={sendHeight} />
  </React.StrictMode>
);

// Add resize listener
window.addEventListener('resize', sendHeight);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
