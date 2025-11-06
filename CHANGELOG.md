# Changelog - RestMan Project

## [1.1.0] - 2025-01-06 - Jakarta EE Migration

### ✅ Major Changes - Tomcat 10.1 Compatibility

#### 🔧 Dependencies Migration
- **UPGRADED** Servlet API: `javax.servlet-api:4.0.1` → `jakarta.servlet-api:6.0.0`
- **ADDED** JSP API: `jakarta.servlet.jsp-api:3.1.0`
- **UPGRADED** JSTL: `javax.servlet:jstl:1.2` → `jakarta.servlet.jsp.jstl-api:3.0.0`
- **ADDED** JSTL Implementation: `org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1`

#### 📝 Configuration Updates
- **UPDATED** web.xml: Schema changed to Jakarta EE 9+ (`web-app_6_0.xsd`)
- **CHANGED** Character encoding: Using Jakarta EE 9 native config
- **ADDED** `<finalName>restman</finalName>` in pom.xml for simpler context path

#### 💻 Source Code Migration
- **MIGRATED** All servlet imports: `javax.servlet.*` → `jakarta.servlet.*`
- **UPDATED** 6 servlet controller files:
  - HomeController.java
  - CustomerHomeController.java
  - StaffHomeController.java
  - StaffReportMenuController.java
  - CatalogController.java
  - CustomerRevenueReportController.java

#### 🐳 Docker Support
- **ADDED** Dockerfile (Tomcat 10.1-jdk17 base)
- **ADDED** docker-compose.yml (MySQL 8.0 + RestMan)
- **ADDED** .dockerignore
- **ADDED** Health checks for both services

#### 📚 Documentation
- **ADDED** TOMCAT_10_DEPLOYMENT.md - Deployment guide for Tomcat 10.1
- **ADDED** DOCKER_QUICK_START.md - Docker deployment quick start
- **ADDED** MIGRATION_SUMMARY.md - Migration overview and statistics
- **ADDED** CHANGELOG.md - This file
- **UPDATED** README.md - Added Docker quick start section

#### 🛠️ Tools & Scripts
- **ADDED** migrate-to-jakarta.ps1 - PowerShell script for auto-migration
- **UPDATED** fix-links.ps1 - Updated for new servlet paths

### 🐛 Bug Fixes
- **FIXED** 404 errors when deploying to Tomcat 10.1
- **FIXED** ClassNotFoundException for jakarta.servlet classes
- **FIXED** JSTL tags not working with Tomcat 10.1
- **FIXED** Character encoding issues (Vietnamese text display)

### 📊 Statistics
- Files Modified: 15
- Lines Changed: ~500
- Java Files Migrated: 6
- Dependencies Updated: 4
- New Files Created: 8

### 🔄 Breaking Changes
- **REQUIRES** Tomcat 10.1+ or compatible Jakarta EE 9+ server
- **NOT COMPATIBLE** with Tomcat 9.x or earlier (use v1.0.0 for older Tomcat)

### 📋 Migration Checklist
- [x] Update pom.xml dependencies
- [x] Migrate Java imports
- [x] Update web.xml schema
- [x] Test on Tomcat 10.1
- [x] Add Docker support
- [x] Update documentation
- [x] Verify all features work
- [x] Test character encoding
- [x] Test database connection
- [x] Test all servlets
- [x] Test all JSP pages

---

## [1.0.0] - 2025-01-05 - Initial Release

### ✨ Features
- ✅ Customer Module: Dish search functionality
- ✅ Staff Module: Customer revenue reporting
- ✅ Database: MySQL 8.0 with complete schema
- ✅ UI: Responsive design with modern CSS

### 🏗️ Architecture
- **Backend**: Java 17, Servlet 4.0, JSP, JSTL
- **Frontend**: JSP, CSS, Bootstrap-inspired styling
- **Database**: MySQL 8.0
- **Build**: Maven 3.9+

### 📦 Modules

#### Customer Module
- Browse active menus
- Search dishes by keyword
- View dish details
- Pagination & sorting

#### Staff Module
- Filter customers by date range
- Filter by membership tier
- View customer orders
- View order details
- View and print invoices

### 📝 Components
- **DAOs**: 6 classes (MenuDAO, DishCatalogDAO, OrderDAO, InvoiceDAO, AccountDAO, ReportingDAO)
- **Models**: 9 entities + 4 view models + 9 enums
- **Controllers**: 6 servlets
- **Views**: 13 JSP pages (5 customer + 7 staff + 1 landing)

### 🎨 UI/UX
- Gradient backgrounds
- Card-based layouts
- Breadcrumb navigation
- Responsive tables
- Print-friendly invoice page

### 🔧 Configuration
- Environment variable support (.env)
- Maven profiles
- Database connection pooling
- Session management

### 📚 Documentation
- README.md - Main documentation
- SETUP.md - Installation guide
- ROUTING_GUIDE.md - URL mapping guide
- FIXED_ROUTING_ISSUE.md - Servlet routing explanation
- FIX_LINKS.md - Link fixing guide
- CHECKLIST.md - Feature checklist

### 🐛 Known Issues (Fixed in 1.1.0)
- Not compatible with Tomcat 10.1+ (uses javax.* instead of jakarta.*)
- Context path is long: /RestMan-1.0-SNAPSHOT

---

## Version Compatibility Matrix

| RestMan Version | Tomcat Version | Servlet API | JSTL Version |
|----------------|----------------|-------------|--------------|
| 1.1.0+ | 10.1+ | Jakarta 6.0 | Jakarta 3.0 |
| 1.0.0 | 8.5 - 9.x | javax 4.0 | javax 1.2 |

## Upgrade Guide

### From 1.0.0 to 1.1.0

**If using Tomcat 10.1+:**
```bash
git pull
mvn clean package
# Deploy new restman.war
```

**If staying on Tomcat 9.x:**
- Stay on version 1.0.0
- Or upgrade Tomcat to 10.1+

### From Tomcat 9.x to Tomcat 10.1+

1. Backup your data
2. Update to RestMan 1.1.0
3. Install Tomcat 10.1+
4. Deploy new WAR file
5. Update any custom configurations

## Deprecations

### Version 1.1.0
- **DEPRECATED** Support for Tomcat 8.5 - 9.x
- **DEPRECATED** javax.servlet.* API
- **DEPRECATED** Old JSTL 1.2

### Future Plans (v2.0.0)
- Add authentication & authorization
- Add order management for staff
- Add menu management for staff
- Add ingredient inventory tracking
- Add REST API support
- Add mobile responsive improvements
- Add report export (PDF, Excel)

## Support

For issues and questions:
- Check documentation in the repository
- Review [TOMCAT_10_DEPLOYMENT.md](TOMCAT_10_DEPLOYMENT.md) for deployment issues
- Review [DOCKER_QUICK_START.md](DOCKER_QUICK_START.md) for Docker issues

---

**Latest Version**: 1.1.0 (Jakarta EE Compatible)
**Release Date**: 2025-01-06
**Compatibility**: Tomcat 10.1+, Java 17+, MySQL 8.0+
