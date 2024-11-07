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
  function getEndDate(start){
    const sevenDaysAfter = new Date(new Date(start));
  sevenDaysAfter.setDate(new Date(start).getDate() + 6);
  const sevenDaysAfterFormatted = sevenDaysAfter.toISOString().split('T')[0];
  return sevenDaysAfterFormatted;
  }
  function getStartDate(end){
    const sevenDaysAgo = new Date(new Date(end));
  sevenDaysAgo.setDate(new Date(end).getDate() - 6);
  const sevenDaysAgoFormatted = sevenDaysAgo.toISOString().split('T')[0];
  return sevenDaysAgoFormatted;
  }
  const today = new Date().toISOString().split('T')[0];
  
  const [dates, setDates] = useState([]);
  const [ stats,setStats] = useState([]);
  const [dateStats, setDateStats] = useState([]);
  const [startDate, setStartDate] = useState(getStartDate(new Date(today))); 
  const [endDate, setEndDate] = useState(today); 
  const fetchData = async () => {
    try {
      
      const response = await axios.get("http://localhost:8080/ChildrenCare/stats",{
        params:{startDate, endDate}
      });
      const {statsPerDay, stats, dates} = response.data;
      setStats(stats);
      setDates(dates);
      setDateStats(statsPerDay);

    } catch (error) {
      console.error("Error fetching reservation stats:", error);
    }
  };
  const colors = [
    'rgba(75, 192, 192, 1)',
    'rgba(255, 99, 132, 1)',
    'rgba(54, 162, 235, 1)',
    'rgba(255, 206, 86, 1)',
    'rgba(153, 102, 255, 1)',
  ];
  const chartData = dateStats && dates && dates.length > 0 ? {
    labels: dates.map(date => date.date), // Use the dates for x-axis labels
    datasets: [
      {
        label: 'Success',
        data: dates.map(date => {
          const dayStats = dateStats.find(day => day.date === date.date)?.stats || [];
          const successStat = dayStats.find(stat => stat.name === "success");
          return successStat ? successStat.quantity : 0;
        }),
        borderColor: colors[0],
        fill: false,
      },
      {
        label: 'Cancelled',
        data: dates.map(date => {
          const dayStats = dateStats.find(day => day.date === date.date)?.stats || [];
          const cancelledStat = dayStats.find(stat => stat.name === "cancelled");
          return cancelledStat ? cancelledStat.quantity : 0;
        }),
        borderColor: colors[1],
        fill: false,
      },
      {
        label: 'Submitted',
        data: dates.map(date => {
          const dayStats = dateStats.find(day => day.date === date.date)?.stats || [];
          const submittedStat = dayStats.find(stat => stat.name === "submitted");
          return submittedStat ? submittedStat.quantity : 0;
        }),
        borderColor: colors[2],
        fill: false,
      },
      {
        label: 'Approved',
        data: dates.map(date => {
          const dayStats = dateStats.find(day => day.date === date.date)?.stats || [];
          const approvedStat = dayStats.find(stat => stat.name === "approved");
          return approvedStat ? approvedStat.quantity : 0;
        }),
        borderColor: colors[3],
        fill: false,
      },
      {
        label: 'Pending',
        data: dates.map(date => {
          const dayStats = dateStats.find(day => day.date === date.date)?.stats || [];
          const pendingStat = dayStats.find(stat => stat.name === "pending");
          return pendingStat ? pendingStat.quantity : 0;
        }),
        borderColor: colors[4],
        fill: false,
      },
    ],
  } : { labels: [], datasets: [] };
  const chartOptions = {
    scales: {
      x: {
        title: {
          display: true,
          text: 'Days',
        },
      },
      y: {
        title: {
          display: true,
          text: 'Number of Reservations',
        },
        beginAtZero: true, // Ensures the Y-axis starts at zero
      },
    },
  };
  useEffect(() => {
    fetchData();
  }, [startDate, endDate]);
  

  
  return (
    <div>
      <h2>Reservation Statistics</h2>
      <div>
        <label>
          Start Date:
          <input type="date" value={startDate} onChange={(e)=>
          {
            const newStartDate = e.target.value;
              const calculatedEndDate = getEndDate(newStartDate); // Calculate end date immediately
              setStartDate(newStartDate);
              setEndDate(calculatedEndDate);
            }
           } />
        </label>
        <label>
          End Date:
          <input type="date" value={endDate} onChange={(e) => {
            const newEndDate = e.target.value;
              const calculatedStartDate = getStartDate(newEndDate); // Calculate start date immediately
              setEndDate(newEndDate);
              setStartDate(calculatedStartDate);
          }} />
        </label>
        {/* <button onClick={fetchData}>Update</button> */}
      </div>
      <div style={{width: "1000px"}}>
<Line data={chartData} options={chartOptions}/>
      </div>
      
    </div>
  );
};

export default ReservationChart;
