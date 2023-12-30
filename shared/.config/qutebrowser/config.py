import catppuccin
catppuccin.setup(c, 'mocha', True)

c.auto_save.session = True
c.tabs.position = 'left'
c.colors.webpage.preferred_color_scheme = 'dark'
c.content.javascript.clipboard = 'access-paste'

config.load_autoconfig()
