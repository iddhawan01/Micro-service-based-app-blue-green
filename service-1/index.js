const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('Service 1: Hello from Blue-Green CI/CD!');
});

app.listen(PORT, () => {
  console.log(`Service 1 running on port ${PORT}`);
});