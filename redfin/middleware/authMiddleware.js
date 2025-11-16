// A simple middleware to protect routes with a secret API key.
// In a real-world application, you would use a more robust authentication
// system like JWT (JSON Web Tokens).

const protect = (req, res, next) => {
  const apiKey = req.headers['x-api-key'];
  
  // You should store your secret key in an environment variable
  const secretApiKey = 'YOUR_SUPER_SECRET_API_KEY'; // Replace with a strong, unique key

  if (apiKey && apiKey === secretApiKey) {
    next(); // API key is valid, proceed to the next middleware/controller
  } else {
    res.status(401).json({ message: 'Unauthorized: Missing or invalid API key' });
  }
};

module.exports = { protect };
