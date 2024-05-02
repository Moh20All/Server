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


// Route handler to check if user exists in assure_compte table
app.get('/check-assured/:userId', (req, res) => {
  const userId = req.params.userId;
  // Example SQL query to check if user exists in assure_compte table
  const assureCompteQuery = 'SELECT user_id FROM assure_compte WHERE user_id = ?';
  db.query(assureCompteQuery, [userId], (err, assureCompteResults) => {
    if (err) {
      console.error('Database query error:', err);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }
    
    // If the user_id exists in the assure_compte table
    if (assureCompteResults.length > 0) {
      const user_id = assureCompteResults[0].user_id;
      return res.json({ success: true, user_id });
    } else {
      return res.json({ success: false, message: 'User does not exist in assure_compte table' });
    }
  });
});

// Define the port number
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
