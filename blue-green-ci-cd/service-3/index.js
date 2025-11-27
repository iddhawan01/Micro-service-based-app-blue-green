const express = require('express');
const app = express();
const PORT = process.env.PORT || 8082;

app.get('/', (req, res) => {
  res.send('Service 3: Analytics microservice');
});

app.listen(PORT, () => {
  console.log(`Service 3 running on port ${PORT}`);
});