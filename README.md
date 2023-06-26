# Instagram Stats Visualizer

This project consists of a Django backend and a Flutter app that work together to fetch Instagram data using the Instagram Graph API and display it beautifully.

## Features

- Fetches data about followers, following, comments, and likes of an Instagram account using the Instagram Graph API.
- Stores the data in a Django database and calculates growth statistics compared to previous data (if available).
- Provides a Flutter app with a beautiful UI to enter an Instagram username, fetch the data, and display it with charts and visualizations.

## Requirements

- Python 3.x
- Django
- Flutter

## Setup Instructions

### Django Backend

1. Create a virtual environment (platform-wise):
   - **Windows**:
     ```bash
     python -m venv venv
     venv\Scripts\activate
     ```
   - **macOS/Linux**:
     ```bash
     python3 -m venv venv
     source venv/bin/activate
     ```

2. Install dependencies using `requirements.txt`:
   ```bash
   pip install -r requirements.txt
## Obtaining Access Token
Obtain an Instagram Graph API access token:

1. Create a Facebook Developer account at [https://developers.facebook.com/](https://developers.facebook.com/) if you don't have one.
2. Create a Facebook app and configure the Basic Display settings to obtain an access token.
3. Replace 'ACCESS_TOKEN' in the Django view code with your actual access token.

**Start the Django development server (i.e. host the Django server)**
```bash
python manage.py runserver
```

**The Django backend will be hosted at http://localhost:8000/instagram-data/{username}/**

## Flutter App
Open the Flutter project in your preferred IDE or editor.

1. In the Flutter project's code, open the appropriate file where you fetch Instagram data.

2. Replace 'http://your-django-server/' in the fetchInstagramData() method with the URL of your hosted Django backend.

   (note : the said url is present at line 19 of the instagram_screen.dart file present inside the lib folder)

3. Build and run the Flutter app on an emulator or a physical device:

```bash
flutter run
```
The app will be installed and launched on the selected device/emulator.

Enter an Instagram username in the app and click the "Fetch Data" button to fetch and display the Instagram data.
