import streamlit as st
import os
from pathlib import Path
from pydantic import BaseModel, Field
from datetime import datetime
import json

# -----------------------------
# CONFIG
# -----------------------------
AGENTS_DIR = "agents"
HISTORY_FILE = "history.json"

# -----------------------------
# MODELS
# -----------------------------
class Message(BaseModel):
    text: str = Field(...)
    agent: str = Field(...)
    timestamp: str = Field(default_factory=lambda: datetime.utcnow().isoformat())

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

def save_to_history(msg: Message):
    history = load_history()
    history.append(msg.dict())
    with open(HISTORY_FILE, "w", encoding="utf-8") as f:
        json.dump(history, f, indent=2)

def load_history():
    if not os.path.exists(HISTORY_FILE):
        return []
    with open(HISTORY_FILE, "r", encoding="utf-8") as f:
        return json.load(f)

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
        .message-box {
            background-color: #222;
            padding: 0.75rem;
            border-radius: 0.5rem;
            margin-bottom: 0.5rem;
        }
    </style>
    """, unsafe_allow_html=True)

    st.title("🧠 Primus Stack — Agent Hub")
    st.caption("Interact with available agents, view logs, and configure the hub.")

    tabs = st.tabs(["🛰️ Agents", "📜 History", "⚙️ Settings"])

    # AGENTS TAB
    with tabs[0]:
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
            st.markdown(agent_specs[agent_choice], unsafe_allow_html=True)

            st.divider()

            st.markdown("### 💬 Send a Message")
            user_input = st.text_input("What do you want to say?")

            if st.button("Send"):
                msg = Message(text=user_input, agent=agent_choice)
                reply = stub_handler(msg.agent, msg.text)
                save_to_history(msg)
                st.success(reply)

    # HISTORY TAB
    with tabs[1]:
        st.subheader("📜 Message History")
        history = load_history()
        if not history:
            st.info("No messages sent yet.")
        else:
            for item in reversed(history[-25:]):
                st.markdown(f"""
                <div class='message-box'>
                    <b>{item['timestamp']}</b><br>
                    <i>{item['agent']}</i>: {item['text']}
                </div>
                """, unsafe_allow_html=True)

    # SETTINGS TAB
    with tabs[2]:
        st.subheader("⚙️ Settings")
        if st.button("🧹 Clear Message History"):
            os.remove(HISTORY_FILE) if os.path.exists(HISTORY_FILE) else None
            st.success("Message history cleared.")

if __name__ == '__main__':
    main()
