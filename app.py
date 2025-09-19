import streamlit as st
import os
from pathlib import Path

# If you're using pydantic, but largely optional here
from pydantic import BaseModel, Field

# Message model (optional)
class Message(BaseModel):
    text: str = Field(..., description="User message")
    agent: str = Field(..., description="Which agent to use")

# Directory with your agent specs
AGENTS_DIR = "agents"  # adjust path if needed

def load_agent_specs():
    specs = {}
    p = Path(AGENTS_DIR)
    if not p.exists():
        return specs
    for md in p.glob("*.md"):
        name = md.stem  # file name without extension
        content = md.read_text(encoding="utf-8")
        specs[name] = content
    return specs

def stub_handler(agent_name: str, message: str) -> str:
    # Simple stub response
    return f"Agent **{agent_name}** received: {message}"

def main():
    st.set_page_config(page_title="Project NOVA Agent Hub", page_icon="🧠")
    st.title("🚀 Project NOVA: Agent Hub Demo")

    # load specs
    agent_specs = load_agent_specs()
    if not agent_specs:
        st.error("No agent spec files found in `agents/` folder.")
        return

    # pick an agent
    agent_names = list(agent_specs.keys())
    agent_choice = st.selectbox("Select an agent", agent_names)

    # display spec
    spec_md = agent_specs[agent_choice]
    st.markdown(f"### Spec for **{agent_choice}**")
    st.markdown(spec_md)

    # user message
    user_text = st.text_input("Send a message to this agent:")

    if st.button("Send"):
        response = stub_handler(agent_choice, user_text)
        st.markdown("**Response:**")
        st.write(response)

if __name__ == "__main__":
    main()
