c.scrolling.smooth = True
c.zoom.default = 200
c.input.insert_mode.auto_load= True
c.messages.timeout = 5000
config.bind('k', 'repeat 2 scroll up')
config.bind('j', 'repeat 2 scroll down')
config.bind('d', 'repeat 10 scroll down')
config.bind('x', 'tab-close')
config.bind('e', 'hint links spawn mpv {hint-url} --ontop --no-border')
