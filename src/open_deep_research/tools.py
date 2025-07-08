"""Utility search and scraping tools."""

import os
from typing import List

try:
    from crawl4ai import AsyncWebCrawler
except ImportError:  # pragma: no cover - optional dependency
    AsyncWebCrawler = None
from langchain_core.documents import Document
from tavily import TavilyClient
from langchain_core.tools import tool

# Instantiate Tavily client using environment variable
_tavily_client = TavilyClient(api_key=os.getenv("TAVILY_API_KEY"))


@tool
def tavily_search(query: str) -> List[Document]:
    """Search the web using Tavily API."""
    return _tavily_client.search(query, count=5)


@tool
async def crawl_url(url: str) -> str:
    """Return the markdown from crawling a URL."""
    if AsyncWebCrawler is None:
        raise ImportError("crawl4ai is required for crawl_url")
    async with AsyncWebCrawler() as crawler:
        return (await crawler.arun(url=url)).markdown


__all__ = ["tavily_search", "crawl_url"]
