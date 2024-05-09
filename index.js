// Import the Express module
const express = require('express');
const app = express();
const db = require('./src/config/mysql');
const cors = require('cors');
app.use(cors())
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
  const assureCompteQuery = 'SELECT ass_id FROM assure_compte WHERE user_id = ?';
  db.query(assureCompteQuery, [userId], (err, assureCompteResults) => {
    if (err) {
      console.error('Database query error:', err);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }
    
    // If the user_id exists in the assure_compte table
    if (assureCompteResults.length > 0) {
      const user_id = assureCompteResults[0].user_id;
      console.log(user_id)
      return res.json({ success: true, user_id });
    } else {
      console.log("Not assure")
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
    //console.log(results);
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

// Function to generate a random alphanumeric string of length 5
function generateId() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let id = '';
  for (let i = 0; i < 5; i++) {
      id += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return id;
}

app.post('/insert-request', (req, res) => {
  // Extract request data from the request body
  const { firstName, lastName, email, password ,idcmp} = req.body;

  console.log('Received request:', req.body);

  // Generate a unique ID
  let id;
  do {
      id = generateId();
      // Check if the generated ID already exists in the database
      db.query('SELECT id FROM requests WHERE id = ?', [id], (err, result) => {
          if (err) {
              console.error('Error checking ID existence:', err);
              return res.status(500).json({ success: false, message: 'Error checking ID existence' });
          }
          if (result.length > 0) {
              // If ID exists, generate a new one
              id = generateId();
          }
      });
  } while (!id);

  console.log('Generated ID:', id);

  // Construct the SQL queries
  const requestQuery = 'INSERT INTO requests (id, name, type, status,company) VALUES (?, ?, ?, ?,?)';
  const userQuery = 'INSERT INTO users (user_id, email, password) VALUES (?, ?, ?)';

  // Combine firstName and lastName into a single name
  const name = `${firstName} ${lastName}`;

  console.log('Constructed name:', name);

  // Execute the first SQL query to insert into requests table
  db.query(requestQuery, [id, name, 1, 0,idcmp], (err1, result1) => {
      if (err1) {
          console.error('Error inserting request:', err1);
          return res.status(500).json({ success: false, message: 'Error inserting request' });
      }

      console.log('Inserted request:', result1);

      // Execute the second SQL query to insert into users table
      db.query(userQuery, [id, email, password], (err2, result2) => {
          if (err2) {
              console.error('Error inserting user:', err2);
              // Rollback the first query if the second query fails
              db.query('DELETE FROM requests WHERE id = ?', [id], (rollbackErr, rollbackResult) => {
                  if (rollbackErr) {
                      console.error('Error rolling back request insertion:', rollbackErr);
                  }
              });
              return res.status(500).json({ success: false, message: 'Error inserting user' });
          }
          
          console.log('Inserted user:', result2);

          // Return success response
          res.json({ success: true, message: 'Request and user inserted successfully' });
      });
  });
});

app.get('/fetch-requests', (req, res) => {
  // Construct the SQL query to fetch all requests
  const query = 'SELECT * FROM requests WHERE type = 1';
  

  // Execute the SQL query
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching requests:', err);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }
    
    // Return the results as JSON
    res.json({ success: true, data: results });
  });
});

// Define the port number
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
