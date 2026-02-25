# 💳 Paymenter for Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/TO_CHANGE)

This is a containerized version of **Paymenter** specifically optimized for a seamless deployment on **Railway**. It features a smart initialization script that automatically configures the application upon the first launch.

## 🚀 About Paymenter
Paymenter is an open-source billing, client management, and support platform designed for hosting providers and digital service companies.

* **Automated Billing**: Manage subscriptions and recurring payments with ease.
* **Integrated Support**: Full ticketing system to assist your customers.
* **Extensibility**: Supports numerous gateways (Stripe, PayPal) and extensions (Pterodactyl, Proxmox).
* **Client Area**: A modern and intuitive interface for your users.

---

## 🏗️ Architecture & Dependencies

The image is built on a robust PHP 8.2+ environment with the following components:

| Component | Role |
| :--- | :--- |
| **PHP-FPM** | Executes the Laravel core. |
| **Web Server** | High-performance Nginx/Apache. |
| **Supervisord** | Process manager for background queue workers. |

Dependencies :
| Service | Role |
| :--- | :--- |
| **MySQL** | MySQL DB to store data. |
| **Redis** | Queue service. |

---

## 🛠️ Railway Installation

1.  Click the **Deploy on Railway** button above.
2.  Configure the mandatory environment variables.
3.  Deployment handles the rest!

### Mandatory Environment Variables

| Variable | Description |
| :--- | :--- |
| `APP_URL` | Your project URL (e.g., `https://your-project.up.railway.app`) **used during initialization**. |
| `COMPANY_NAME` | Your company name **used during initialization**. |
| `ADMIN_EMAIL` | The admin account e-mail **used during the initialization**. |
| `ADMIN_PASSWORD` | The admin account password **used during the initialization**. |

These 4 variables can safely be removed after the first deployment succeed as they will not be reused and they can be destructive.

All the other variables are automatically generated and are mandatory. Removing them can break your install !
---

## 🔄 "Railway Tweaks" System

This repository utilizes a **Custom Entrypoint** to manage the lifecycle on Railway effectively:

* **Auto-Initialization**: On the first boot, the script runs `php artisan app:init`, database seeders and create an admin user.
* **Persistence**: A sentinel file (`.railway_initialized`) is created in the `/app/storage` directory. This prevents installation commands from re-running on subsequent restarts.
* **Handoff**: Once tweaks are applied, the script hands over control to the main process (`supervisord`) to ensure the container stays healthy and active.

---

## ❗Note
After the first deployment succeed, there are a few settings u may need to change inside the web app. Please refer to [Payment Docs](https://paymenter.org/docs). Here is a short list (it may not be exhaustive) :
- **Trusted Proxies (Mandatory on Railway)**
- System Email Address (Used to send CronJob failures, updates, etc...)
- Admin name (Both set to `CHANGEME` on installation)
- SMTP credentials
- Tax settings
- Invoice settings
- Themes

## 📜 License
This project is distributed under the **MIT License**. Paymenter is an open-source project created by the community. For more details on the original software, visit [paymenter.org](https://paymenter.org).

---

Developed with ❤️ for the Railway community.