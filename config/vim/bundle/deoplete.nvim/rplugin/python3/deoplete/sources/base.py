# ============================================================================
# FILE: base.py
# AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
# License: MIT license
# ============================================================================

import re
from abc import abstractmethod
from deoplete.logger import LoggingMixin


class Base(LoggingMixin):

    def __init__(self, vim):
        self.vim = vim
        self.name = 'base'
        self.description = ''
        self.mark = ''
        self.min_pattern_length = -1
        self.max_pattern_length = 80
        self.input_pattern = ''
        self.matchers = [
            'matcher_length', 'matcher_fuzzy']
        self.sorters = ['sorter_rank']
        self.converters = [
            'converter_remove_overlap', 'converter_truncate_abbr']
        self.filetypes = []
        self.is_bytepos = False
        self.rank = 100
        self.disabled_syntaxes = []

    def get_complete_position(self, context):
        m = re.search('(?:' + context['keyword_patterns'] + ')$',
                      context['input'])
        return m.start() if m else -1

    @abstractmethod
    def gather_candidate(self, context):
        pass
