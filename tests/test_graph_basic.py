from open_deep_research.configuration import WorkflowConfiguration


def test_default_planner_model():
    config = WorkflowConfiguration.from_runnable_config()
    assert config.planner_model == "qwen/qwen3-32b"
