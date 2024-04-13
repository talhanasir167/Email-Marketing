# Email Marketing Application

Welcome to the Email Marketing Application! This application is designed to streamline your email marketing efforts by allowing you to send bulk emails to multiple businesses, schedule follow-ups, and manage your email credentials seamlessly.

## Features

- **Bulk Email Sending:** Send bulk emails to multiple businesses with ease.
- **Scheduled Emails/Follow-ups:** Schedule emails and follow-ups for future delivery.
- **Dynamic Email Setup:** Users can update business emails and email credentials on the fly.
- **Authentication:** Utilizes Devise for secure user authentication.
- **Background Processing:** Sidekiq is integrated for efficient background processing of emails.
- **Local Email Testing:** Includes Letter Opener gem for easy testing of emails locally.

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- Ruby 3.2.2
- Rails 7.0.8
- PostgreSQL

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/usman-zulfiqar065/Email-Marketing-Application.git

2. Navigate to the project directory:
   
   ```bash
   cd gpt-email
   
3. Install dependencies:
   
   ```bash
   bundle install

4. Set up the database:

   ```bash
   rake db:setup

5. Start the Sidekiq server for background processing:

   ```bash
   bundle exec sidekiq

6. Start the Rails server:

   ```bash
   rails server

7. Open your web browser and visit http://localhost:3000 to access the application.


