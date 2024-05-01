// Import the Express module
const express = require('express');
const app = express();
const db = require('./src/config/mysql');

// Parse JSON bodies
app.use(express.json());

// Route handler for login
app.post('/login', (req, res) => {
  const { email, password } = req.body;
  
  // Log the request
  console.log('Request received:', req.body);
  
  // Example SQL query (assuming you're using MySQL)
  const query = 'SELECT user_id, email FROM users WHERE email = ? AND password = ?';
  db.query(query, [email, password], (err, results) => {
    if (err) {
      console.error('Database query error:', err);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }
    
    if (results.length === 0) {
      return res.status(401).json({ success: false, message: 'Invalid email or password' });
    }
    
    const user = results[0];
    res.json({ success: true, user });
  });
});

// Define the port number
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
