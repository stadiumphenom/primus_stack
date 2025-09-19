import streamlit as st
from pydantic import BaseModel

class User(BaseModel):
    name: str
    age: int

st.title("✅ Pydantic Streamlit Works")

name = st.text_input("Name")
age = st.number_input("Age", min_value=0, step=1)

try:
    user = User(name=name, age=age)
    st.success(f"Valid: {user}")
except Exception as e:
    st.error(str(e))
