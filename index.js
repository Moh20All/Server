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

// Endpoint to get details of an assurance with a specific ass_id
app.get('/assure-details', (req, res) => {

  const { ass_id } = req.query;

  const query = `
    SELECT assure.ass_id, assure.nom_ass, assure.prenom_ass, contrat.*, car.*
    FROM assure
    JOIN assure_contrat ON assure.ass_id = assure_contrat.ass_id
    JOIN contrat ON assure_contrat.contrat_id = contrat.contrat_id
    JOIN contrat_cars ON contrat.contrat_id = contrat_cars.contrat_id
    JOIN car ON contrat_cars.car_id = car.car_id
    WHERE assure.ass_id = ?;
  `;

  db.query(query, [ass_id], (err, results) => {
    if (err) {
      console.error('Error executing SQL query:', err);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }

    // Return the results as JSON
    res.json({ success: true, data: results });
  });
});




app.get('/user-details/:userId', (req, res) => {
  const userId = req.params.userId;
  // Example SQL query to check if user exists in assure_compte table
  const assureCompteQuery = 'SELECT FirstName,LastName FROM users WHERE user_id = ?';
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
