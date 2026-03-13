import requests
import time

BASE_URL = "http://localhost:8000"

def test_signup():
    print("Testing User Signup...")
    # Use a timestamp in the email to avoid "User already exists" errors on multiple runs
    test_email = f"test@gmail.com"
    
    payload = {
        "username": "testuser",
        "email": test_email,
        "password": "hello123",
        "first_name": "API",
        "last_name": "Tester",
        "role": "user"
    }
    
    try:
        response = requests.post(f"{BASE_URL}/auth/signup", json=payload)
        
        if response.status_code == 200:
            print("✅ Signup Successful! Data was saved to Appwrite.")
            print("Response:", response.json())
            return payload
        else:
            print(f"❌ Signup Failed! Status Code: {response.status_code}")
            print("Error Details:", response.text)
            return None
    except requests.exceptions.ConnectionError:
        print(f"❌ Connection Error! Make sure your backend server is running on {BASE_URL}")
        return None

def test_login(email, password):
    print("\nTesting User Login...")
    payload = {
        "email": email,
        "password": password
    }
    
    try:
        response = requests.post(f"{BASE_URL}/auth/login", json=payload)
        
        if response.status_code == 200:
            print("✅ Login Successful! JWT token generated.")
            data = response.json()
            print(f"Token received: {data.get('access_token')[:30]}... (truncated)")
            print(f"User ID: {data.get('user_id')}")
        else:
            print(f"❌ Login Failed! Status Code: {response.status_code}")
            print("Error Details:", response.text)
    except requests.exceptions.ConnectionError:
         print("❌ Connection Error!")

if __name__ == "__main__":
    print(f"--- Health App API Tester ---")
    print(f"Ensure your FastAPI server is running on {BASE_URL}")
    print("-" * 50)
    
    user_data = test_signup()
    
    if user_data:
        test_login(user_data["email"], user_data["password"])
