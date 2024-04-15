import sys
sys.path.insert(0, r'/home/working/Projects/cmcm-1/docs')

project = 'CMCM'
copyright = '2023, flagarde'
author = 'flagarde'
release = '0.1'
pygments_style = 'colors.CMakeTemplateStyle'
latex_engine = 'lualatex'
extensions = ['sphinxcontrib.moderncmakedomain','sphinx.ext.intersphinx']
latex_elements = {'fontpkg': '''''',}
html_css_files = ['/home/working/Projects/cmcm-1/docs/css/custom.css']
nitpicky = True
smartquotes = False
templates_path = ['/home/working/Projects/cmcm-1/docs/templates']
exclude_patterns = []
html_theme = 'classic'
primary_domain = 'cmake'
highlight_language = 'none'
html_static_path = ['/home/working/Projects/cmcm-1/docs/static']
html_show_sourcelink = False
html_show_sphinx = False
html_theme_options = {
    'footerbgcolor':    '#00182d',
    'footertextcolor':  '#ffffff',
    'sidebarbgcolor':   '#e4ece8',
    'sidebarbtncolor':  '#00a94f',
    'sidebartextcolor': '#333333',
    'sidebarlinkcolor': '#00a94f',
    'relbarbgcolor':    '#00529b',
    'relbartextcolor':  '#ffffff',
    'relbarlinkcolor':  '#ffffff',
    'bgcolor':          '#ffffff',
    'textcolor':        '#444444',
    'headbgcolor':      '#f2f2f2',
    'headtextcolor':    '#003564',
    'headlinkcolor':    '#3d8ff2',
    'linkcolor':        '#2b63a8',
    'visitedlinkcolor': '#2b63a8',
    'codebgcolor':      '#eeeeee',
    'codetextcolor':    '#333333',
    'body_max_width' : '100%',
}
