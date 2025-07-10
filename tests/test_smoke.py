import subprocess
import importlib
import time
import signal


def test_import_graph():
    mod = importlib.import_module("open_deep_research.graph")
    assert hasattr(mod, "graph")


def test_dev_server_boots():
    proc = subprocess.Popen(
        ["langgraph", "dev"],
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
    )
    try:
        t0 = time.time()
        while time.time() - t0 < 15:
            line = proc.stdout.readline()
            if "Welcome to" in line:
                return
        raise AssertionError("Dev server banner not seen in 15 s")
    finally:
        proc.send_signal(signal.SIGTERM)
