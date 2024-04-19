// Import the Express module
const express = require('express');
const fs = require('fs');
const app = express();

// Define a route handler for the root URL
app.get('/', (req, res) => {
    // Read the contents of the user.json file
    fs.readFile('DB/user.json', 'utf8', (err, data) => {
        if (err) {
            // Handle error if file reading fails
            console.error('Error reading user.json:', err);
            res.status(500).json({ message: 'Internal server error' });
            return;
        }
        
        try {
            // Parse the JSON data
            const userData = JSON.parse(data);
            // Send the parsed JSON data as the response
            res.json(userData);
        } catch (parseError) {
            // Handle error if JSON parsing fails
            console.error('Error parsing user.json:', parseError);
            res.status(500).json({ message: 'Internal server error' });
        }
    });
});


// Define the port number
const port = process.env.PORT || 3000;

// Start the server
app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});
