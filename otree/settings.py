from os import environ
from dotenv import load_dotenv
load_dotenv('../secrets.env')

SESSION_CONFIGS = [
    dict(
        name='trust',
        display_name="Trust Game",
        app_sequence=['trust'],
        num_demo_participants=2,
    ),
    dict(
        name='ftrust',
        display_name="Framed Trust Game",
        app_sequence=['ftrust'],
        num_demo_participants=2,
    ),
    dict(
        name='deception',
        display_name="Deception Game",
        app_sequence=['deception'],
        num_demo_participants=2,
    ),
    dict(
        name='fdeception',
        display_name="Framed Deception Game",
        app_sequence=['fdeception'],
        num_demo_participants=2,
    ),
    dict(
        name='honesty',
        display_name="Neutral variant of experiment 1 in Evans III et al. (2001)",
        app_sequence=['honesty'],
        num_demo_participants=1
    )
]

# if you set a property in SESSION_CONFIG_DEFAULTS, it will be inherited by all configs
# in SESSION_CONFIGS, except those that explicitly override it.
# the session config can be accessed from methods in your apps as self.session.config,
# e.g. self.session.config['participation_fee']

SESSION_CONFIG_DEFAULTS = dict(
    real_world_currency_per_point=1.00, participation_fee=0.00, doc=""
)

PARTICIPANT_FIELDS = [
    'wealth', 'comprehension_check', 'comprehension_check1', 
    'comprehension_check2', 'manipulation_check', 
    'human_check', 'feedback'
]
SESSION_FIELDS = []

# ISO-639 code
# for example: de, fr, ja, ko, zh-hans
LANGUAGE_CODE = 'en'

# e.g. EUR, GBP, CNY, JPY
REAL_WORLD_CURRENCY_CODE = 'USD'
USE_POINTS = True

ROOMS = [
    dict(name='live_demo', display_name='Room for live demo (no participant labels)'),
]

ADMIN_USERNAME = 'admin'
# for security, best to set admin password in an environment variable
ADMIN_PASSWORD = environ.get('OTREE_ADMIN_PASSWORD')

DEMO_PAGE_INTRO_HTML = """
Here are some oTree games.
"""

SECRET_KEY = environ.get('OTREE_REST_KEY')

INSTALLED_APPS = ['otree']
