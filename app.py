# app.py
import streamlit as st
from pydantic import BaseModel, Field

class User(BaseModel):
    name: str = Field(..., description="User's name")
    age: int = Field(..., description="User's age")

st.title("🧪 Pydantic Streamlit Demo")

st.markdown("This app uses `pydantic` to define a simple user model.")

name = st.text_input("Enter your name:")
age = st.number_input("Enter your age:", min_value=0, max_value=150)

if st.button("Create User"):
    try:
        user = User(name=name, age=age)
        st.success(f"✅ Valid user: {user}")
    except Exception as e:
        st.error(f"❌ Error: {e}")
