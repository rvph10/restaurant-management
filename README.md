# Restaurant Management System 🍽️

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node](https://img.shields.io/badge/Node-v18.0%2B-brightgreen)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-v18.2.0-blue)](https://reactjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-v5.3.2-blue)](https://www.typescriptlang.org/)
[![Docker](https://img.shields.io/badge/Docker-v24.0%2B-blue)](https://www.docker.com/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

A comprehensive restaurant management system featuring real-time delivery tracking, task management, and order processing. Built with modern technologies and scalable architecture.

![Restaurant Management System](https://via.placeholder.com/800x400?text=Restaurant+Management+System)

## ✨ Features

- 📱 Real-time delivery tracking
- 🧹 Task management for cleaning and maintenance
- 👥 Role-based order processing
- 🔄 Real-time order status updates
- 📦 Inventory management
- 🔐 Secure authentication system
- 📊 Analytics dashboard

## 🚀 Tech Stack

### Frontend
- **Framework:** React 18 with TypeScript
- **State Management:** Redux Toolkit
- **Styling:** TailwindCSS
- **Real-time Communication:** Socket.IO Client
- **Routing:** React Router v6

### Backend
- **Runtime:** Node.js with Express
- **Language:** TypeScript
- **Database:** PostgreSQL
- **Caching:** Redis
- **Real-time:** Socket.IO
- **Authentication:** JWT

### DevOps
- **Containerization:** Docker & Docker Compose
- **Version Control:** Git & GitHub
- **CI/CD:** GitHub Actions
- **Development:** WSL2 with Ubuntu

## 📋 Prerequisites

Before you begin, ensure you have met the following requirements:

- Node.js >= 18.0.0
- Docker >= 24.0.0
- Docker Compose >= 2.0.0
- Git >= 2.0.0
- WSL2 with Ubuntu (for Windows users)

## 🛠️ Installation

1. Clone the repository:
```bash
git clone https://github.com/rvph10/restaurant-management.git
cd restaurant-management
```

2. Install dependencies:
```bash
npm run setup
```

3. Set up environment variables:
```bash
# Copy example env files
cp .env.example .env
cp client/.env.example client/.env
cp server/.env.example server/.env
```

4. Start the development environment:
```bash
docker-compose up
```

The application will be available at:
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000
- API Documentation: http://localhost:5000/api-docs

## 🏗️ Project Structure

```
restaurant-management/
├── client
│   └── src
│       ├── assets
│       ├── components
│       │   ├── common
│       │   ├── layout
│       │   └── specific
│       ├── config
│       ├── features
│       │   ├── auth
│       │   ├── cleaning
│       │   ├── delivery
│       │   └── orders
│       ├── hooks
│       ├── services
│       ├── store
│       ├── types
│       └── utils
├── docker
└── server
    └── src
        ├── config
        ├── controllers
        ├── middleware
        ├── models
        ├── routes
        ├── services
        ├── sockets
        └── utils
```

## 🔨 Scripts

```bash
# Development
npm run dev         # Start both client and server in development mode
npm run client      # Start client only
npm run server      # Start server only
npm run setup       # Install npm dependecies 

# Production
npm run build       # Build both client and server
npm start           # Start production server
```

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage
```

## 📝 API Documentation

API documentation is available at `/api-docs` when running the server. It includes:
- Endpoint descriptions
- Request/response examples
- Authentication requirements
- WebSocket events

## 🤝 Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please ensure you have:
- [ ] Added tests for new features
- [ ] Updated documentation
- [ ] Followed the code style guidelines
- [ ] Added appropriate comments

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **RVPH** - _Initial work_ - [rvph10](https://github.com/rvph10)

## 📞 Support

For support, please open an issue in the GitHub repository or contact the development team.

## 🙏 Acknowledgments

- React Team for the amazing framework
- Docker Team for containerization
- All contributors who have helped this project

---
⭐️ Star me on GitHub — it motivates a lot!