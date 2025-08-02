const http = require('http');

const hostname = '0.0.0.0'; // The crucial part
const port = 3001;

const server = http.createServer((req, res) => {
  console.log(`Minimal server received a request! URL: ${req.url}`);
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Success! The connection is working.\n');
});

server.listen(port, hostname, () => {
  console.log(`--- Minimal Server is Running ---`);
  console.log(`Test from PC browser: http://localhost:${port}/`);
  console.log(`---------------------------------`);
}); 