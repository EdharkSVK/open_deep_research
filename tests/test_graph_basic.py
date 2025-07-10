import asyncio
import os
import pytest
from open_deep_research.graph import graph


def test_graph_runs_basic():
    config = {"configurable": {"thread_id": "test"}}
    if os.getenv("GROQ_API_KEY", "dummy-key") == "dummy-key":
        pytest.skip("GROQ_API_KEY not configured")
    result = asyncio.run(graph.ainvoke({"topic": "Cats"}, config))
    assert result.get("final_report")
    assert any(s.research for s in result["sections"])
