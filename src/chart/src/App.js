// App.js

import React, { useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

import { Line } from 'react-chartjs-2';
import ReservationChart from './Line';

function App({ onLoad }) {
  useEffect(() => {
    if (onLoad) {
      onLoad();
    }
  }, [onLoad]);

  return (
    <Router basename="/react">
      <Routes>
        <Route path="/chart" element={<ReservationChart />} />
      </Routes>
    </Router>
  );
}

export default App;
