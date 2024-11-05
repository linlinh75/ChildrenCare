// ReservationChart.js

import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);
const ReservationChart = () => {
  const [data, setData] = useState({});
  const [startDate, setStartDate] = useState('2024-09-19'); // Default start date
  const [endDate, setEndDate] = useState('2024-09-25'); // Default end date

  const fetchData = async () => {
    try {
      const response = await axios.get('http://localhost:8080/ChildrenCare/stats', {
        params: { startDate, endDate },
      });
      setData(response.data);
    } catch (error) {
      console.error("Error fetching reservation stats:", error);
    }
  };

  useEffect(() => {
    fetchData();
  }, [startDate, endDate]);

  const chartData = {
    labels: Object.keys(data), // ["success", "cancelled", "submitted"]
    datasets: [
      {
        label: 'Reservations',
        data: Object.values(data), // [5, 3, 7] - example values
        borderColor: 'rgba(75, 192, 192, 1)',
        fill: false,
      },
    ],
  };

  return (
    <div>
      <h2>Reservation Statistics</h2>
      <div>
        <label>
          Start Date:
          <input type="date" value={startDate} onChange={(e) => setStartDate(e.target.value)} />
        </label>
        <label>
          End Date:
          <input type="date" value={endDate} onChange={(e) => setEndDate(e.target.value)} />
        </label>
        <button onClick={fetchData}>Update</button>
      </div>
      <Line data={chartData} />
    </div>
  );
};

export default ReservationChart;
