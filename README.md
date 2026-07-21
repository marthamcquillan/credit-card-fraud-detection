# Credit Card Fraud Detection

A full-stack web application for detecting potentially fraudulent credit card transactions using PostgreSQL triggers, secure authentication, and a Flask backend.

## Overview

This project implements a rule-based credit card fraud detection platform that allows users to securely manage accounts, submit transactions, and automatically identify suspicious transaction patterns.

Rather than relying on machine learning, fraud detection is implemented directly within PostgreSQL using SQL triggers. This approach enables immediate detection of suspicious activity as transactions are recorded while maintaining strong data integrity and application performance.

The application combines a Flask backend, PostgreSQL database, Supabase Authentication, and a web-based interface to provide an end-to-end transaction management system.

---

## Features

- Secure user authentication with Supabase
- Transaction submission and management
- PostgreSQL relational database
- SQL trigger-based fraud detection
- Flask backend
- HTML/CSS frontend

---

## Fraud Detection

Fraud detection is implemented at the database level using PostgreSQL triggers.

The system automatically monitors newly inserted transactions and flags suspicious activity based on predefined rules, including rapid consecutive transactions occurring within a short time interval.

Implementing fraud detection within the database ensures:

- Immediate detection when transactions are inserted
- Consistent enforcement of business rules
- Reduced application-side complexity
- Reliable transaction integrity

---

## Database Design

The relational database supports:

- User accounts
- Secure authentication
- Transaction history
- Fraud alerts

Database constraints, foreign keys, and SQL triggers work together to maintain consistency while supporting automated fraud detection.

---

## My Contributions

This repository represents a collaborative software engineering project with Sanjan Gadde, Mattias Larsson, Jacky Chan, and Vishram Doodnauth.

My primary contributions included:

- Designing he PostgreSQL relational database schema
- Implementing SQL triggers for rule-based fraud detection
- Building secure login and authentication using Supabase
- Developing Flask backend functionality for user account management
