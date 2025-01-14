import re
from random import choice
from urllib.request import urlopen

from bs4 import BeautifulSoup

WIKI_URL = 'https://pt.wikipedia.org'

KEVIN_BACON_URL = f'{WIKI_URL}/wiki/Kevin_Bacon'


class SurfaceArticle:
    def __init__(self):
        self._wiki = None
        self._file = None
        self._urls = []
        self._url = ''
        self._next_url = ''

    def surface(self, url):
        with urlopen(url, timeout=5) as page:
            self._wiki = BeautifulSoup(page.read(), 'html.parser')

        self._file = open('log.log', 'a')

        self._write_current_page()
        self._find_all_urls_of_page()
        self._find_next_url()
        self._write_next_page()

        self.surface(self._next_url)

    def _write_current_page(self):
        self._file.write(f'Current page {self._url}\n')
        self._file.write(f'Page title {self._wiki.h1.get_text()}\n')

    def _find_all_urls_of_page(self):
        links = self._wiki.find_all(
            'a', {'href': re.compile(r'/wiki/((?!:).)*$')})
        self._urls = [
            f'{WIKI_URL}{link.attrs["href"]}' for link in links]

    def _find_next_url(self):
        while True:
            self._next_url = choice(self._urls)
            try:
                with urlopen(self._next_url, timeout=5):
                    break
            except Exception:
                pass

    def _write_next_page(self):
        self._file.write(f'Next page {self._next_url}\n')


if __name__ == '__main__':
    try:
        SurfaceArticle().surface(KEVIN_BACON_URL)
    except KeyboardInterrupt:
        pass
