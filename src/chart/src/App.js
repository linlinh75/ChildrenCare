// App.js

import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import { Line } from 'react-chartjs-2';
import ReservationChart from './Line';

function App() {
  return (
    <Router basename="/react">
      <Routes>
        <Route path="/chart" element={<ReservationChart/>} />
        {/* Add other routes as needed */}
      </Routes>
    </Router>
  );
}

export default App;
