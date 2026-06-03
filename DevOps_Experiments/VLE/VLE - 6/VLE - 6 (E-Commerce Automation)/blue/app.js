const http = require("http");
const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ status: "healthy" }));
    return;
  }
  res.writeHead(200, { "Content-Type": "text/html" });
  res.end("<html><body><h1>I am Jashanveer Mandhan RA2311003010204 from SRMIST.</h1><h2>Q6: E-Commerce Deployment Solution</h2><p><b>Problem:</b> Frequent deployment failures, manual server setup, downtime during releases.</p><p><b>Solution:</b> Automated Blue-Green Deployment using Terraform, Ansible, Docker and Nginx.</p><p>Current Environment: BLUE (Stable v1.0)</p></body></html>");
});
server.listen(4000, () => console.log("Blue on 4000"));