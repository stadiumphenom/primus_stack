import streamlit as st
import os
from pathlib import Path
from pydantic import BaseModel, Field

# -----------------------------
# CONFIG
# -----------------------------
AGENTS_DIR = "agents"

# -----------------------------
# MODELS
# -----------------------------
class Message(BaseModel):
    text: str = Field(...)
    agent: str = Field(...)

# -----------------------------
# HELPERS
# -----------------------------
def load_agent_specs():
    specs = {}
    p = Path(AGENTS_DIR)
    if not p.exists():
        return specs
    for md in p.glob("*.md"):
        name = md.stem.replace("-agent", "").replace("_", " ").title()
        specs[name] = md.read_text(encoding="utf-8")
    return specs

def stub_handler(agent_name: str, message: str) -> str:
    return f"\n🤖 **{agent_name}** says: _'You said \"{message}\".'_"

# -----------------------------
# MAIN APP
# -----------------------------

def main():
    st.set_page_config(page_title="Primus Stack — Agent Hub", layout="wide")

    st.markdown("""
    <style>
        .agent-card {
            padding: 1rem;
            border: 1px solid #444;
            border-radius: 0.5rem;
            background-color: #111;
            margin-bottom: 1rem;
        }
    </style>
    """, unsafe_allow_html=True)

    st.title("🧠 Primus Stack — Agent Hub")
    st.caption("Interact with available agents below. Specs loaded dynamically.")

    agent_specs = load_agent_specs()
    if not agent_specs:
        st.warning("No agents found in the `agents/` folder.")
        return

    col1, col2 = st.columns([1, 2])

    with col1:
        st.subheader("📦 Agents Available")
        agent_names = list(agent_specs.keys())
        agent_choice = st.radio("Select an Agent:", agent_names)

    with col2:
        st.subheader(f"📄 Agent Spec: {agent_choice}")
        st.markdown(agent_specs[agent_choice])

        st.divider()

        st.markdown("### 💬 Send a Message")
        user_input = st.text_input("What do you want to say?")

        if st.button("Send"):
            msg = Message(text=user_input, agent=agent_choice)
            reply = stub_handler(msg.agent, msg.text)
            st.success(reply)

if __name__ == '__main__':
    main()
