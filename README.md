# 0-simple_web_stack

## Infrastructure Description

User → www.foobar.com → DNS resolves to 8.8.8.8 → Nginx → App Server → MySQL

### Components:
- 1 Server @ 8.8.8.8
- Nginx Web Server
- Gunicorn Application Server
- Codebase (Python/Flask)
- MySQL Database
- Domain Name: foobar.com (www A record)

### DNS:
- Record Type: A
- Maps www.foobar.com → 8.8.8.8

### Communication:
- User to Nginx: HTTPS
- Nginx to App Server: HTTP/UNIX Socket
- App Server to DB: TCP/3306 or UNIX Socket

### Weaknesses:
- Single Point of Failure (SPOF)
- Downtime during deploys/restarts
- No scaling: 1 server limits traffic capacity


# 2-secured_and_monitored_web_infrastructure

## Infrastructure Design for www.foobar.com

A secure and monitored infrastructure composed of:
- 1 Load Balancer (with SSL cert)
- 2 App/Web Servers
- 1 MySQL DB (with firewall)
- Monitoring agents
- HTTPS-only traffic

## Added Components:
- **3 Firewalls** to restrict access per layer
- **SSL Certificate** to enforce encrypted HTTPS
- **3 Monitoring Clients** for logging and metrics (Sumologic, Prometheus, etc.)

## Key Security & Monitoring Practices:
- Firewall rules isolate each component
- HTTPS protects data in transit
- Monitoring captures performance, alerts on failures

## Infrastructure Weaknesses:
- SSL is terminated at the load balancer, not end-to-end
- MySQL is a write SPOF (no automatic failover)
- App servers are not modular (web+app+logs combined)

# 3. Scale Up - Advanced Web Infrastructure Design

This infrastructure is an improvement on the previous version by adding better scalability, modularity, and reliability.

## Key Enhancements

- Added **1 extra server** to support component separation.
- **Load Balancer cluster (HAProxy x2)** for high availability.
- Split roles:
  - **Web Servers (Nginx)**: serve static files and proxy to app.
  - **Application Servers (Gunicorn)**: run dynamic backend logic.
  - **Dedicated MySQL DB Server**: secure, optimized database handling.

## Web Server vs Application Server

| Web Server (Nginx)            | Application Server (Gunicorn)         |
|-------------------------------|----------------------------------------|
| Serves static content         | Runs backend logic                    |
| Acts as reverse proxy         | Executes business logic               |
| Efficient for concurrent traffic | Optimized for code execution         |

## Load Balancer Configuration

- **Cluster Mode**: Active-Active
- **Algorithm**: Round Robin
- **Failover**: keepalived or floating IP

## Summary

This design prepares the infrastructure for larger traffic, better observability, and future improvements like containerization and CI/CD.
