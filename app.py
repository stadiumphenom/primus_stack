import streamlit as st
from pydantic import BaseModel
from typing import Callable

# Define message schema
class Message(BaseModel):
    text: str
    intent: str

# Define simple agent class
class Agent:
    def __init__(self, name: str, handle: Callable[[Message], str], intents: list[str]):
        self.name = name
        self.handle = handle
        self.intents = intents

# Simple intent handlers
def joke_agent(msg): return "Why did the chicken join Streamlit? To build apps!"
def math_agent(msg): return f"2 + 2 = {2 + 2}"
def fallback(msg): return "I don't understand that."

# Create agent instances
agents = [
    Agent("JokeAgent", joke_agent, ["joke", "funny"]),
    Agent("MathAgent", math_agent, ["math", "calculate"]),
]

# Streamlit UI
st.title("🧠 Hub-and-Spoke Routing Demo")

user_input = st.text_input("Say something:")
intent = st.selectbox("Choose intent (simulate NLU)", ["joke", "math", "unknown"])

if st.button("Send"):
    message = Message(text=user_input, intent=intent)
    matched = next((a for a in agents if intent in a.intents), None)
    response = matched.handle(message) if matched else fallback(message)
    st.markdown(f"**Agent Response:** {response}")
