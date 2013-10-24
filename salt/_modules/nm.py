import re
def re_search(pattern, str):
    return re.search(pattern, str)
    
    
def test_matching(value, pattern):
    return bool(re.search(pattern, value))
    
try:    
    from jinja2.defaults import DEFAULT_TESTS
    DEFAULT_TESTS['matching'] = test_matching
except Exception: pass
