const express = require('express');
const app = express();
const PORT = process.env.PORT || 8081;

app.get('/', (req, res) => {
  res.send('Service 2: Business logic microservice');
});

app.listen(PORT, () => {
  console.log(`Service 2 running on port ${PORT}`);
});