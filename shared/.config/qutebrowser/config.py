import catppuccin
catppuccin.setup(c, 'latte', True)

c.auto_save.session = True
c.tabs.position = 'top'
c.colors.webpage.preferred_color_scheme = 'light'
c.content.javascript.clipboard = 'access-paste'

config.load_autoconfig()
