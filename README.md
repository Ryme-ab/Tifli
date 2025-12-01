Tifli – Child Care Mobile App

A smart assistant to help parents monitor and take care of their children.

Overview

Tifli is a mobile application designed to support parents in managing and monitoring their children’s daily needs.
The app provides tools for tracking health, growth, nutrition, sleep, activities, appointments, and more—all in one place.

The backend is powered by Supabase, providing secure authentication, storage, and a relational database.

Features
Child Management

Add and manage multiple children

View child profile, age, birth date, and health information

Health & Medical

Store medical records

Track vaccinations with next-due reminders

Record doctor visits and diagnoses

Growth Tracking

Track height, weight, and head circumference

Visualize growth progress

Nutrition & Meals

Log meals (milk, snacks, breakfast, etc.)

Store nutritional notes and calorie estimates

Sleep Tracking

Log sleep sessions

Monitor sleep quality

Daily Activities

Register daily activities such as playtime, bath, and diaper changes

View history of routines

Appointments

Schedule pediatric appointments

Mark appointments as completed or canceled

Media Uploads

Upload photos, videos, or documents for each child

Store medical files or memories

Notifications

Alerts for vaccinations

Appointment reminders

Tech Stack
Frontend

Flutter / Dart

Responsive UI

Local state management

Backend (Supabase)

PostgreSQL database

Supabase Auth for user accounts

Supabase Storage for media files

Row-Level Security (RLS)

Real-time capabilities

Project Folder Structure (Flutter + Supabase)
tifli/
│
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── child/
│   │   ├── health/
│   │   └── settings/
│   │
│   ├── widgets/
│   ├── models/
│   ├── services/
│   │   ├── supabase_auth.dart
│   │   ├── supabase_children.dart
│   │   ├── supabase_activities.dart
│   │   └── supabase_health.dart
│   │
│   └── utils/
│
├── assets/
│   ├── images/
│   ├── icons/
│   └── screenshots/
│
├── database/
│   ├── schema.sql
│   └── rls_policies.sql
│
├── .env
├── pubspec.yaml
├── README.md
└── android/ / ios/ / web/
