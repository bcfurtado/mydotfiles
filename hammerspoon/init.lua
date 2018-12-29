-- Reload configuration
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")


-- Window management
-- Full Screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "m", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- Two Columns - Window on the Left side
-- |-----|-----|
-- |  X  |     |
-- |-----|-----|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Two Columns - Window on the Right side
-- |-----|-----|
-- |     |  X  |
-- |-----|-----|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Three Columns - Window on the first column starting from the left side
-- |---|---|---|
-- | X |   |   |
-- |---|---|---|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "[", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)

-- Three Columns - Window on the second column starting from the left side
-- |---|---|---|
-- |   | X |   |
-- |---|---|---|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "]", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 3)
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)

-- Three Columns - Window on the third column starting from the left side
-- |---|---|---|
-- |   |   | X |
-- |---|---|---|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "\\", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + 2 * (max.w / 3)
  f.y = max.y
  f.w = max.w / 3
  f.h = max.h
  win:setFrame(f)
end)

-- Three Columns - Window on the first and second columns starting from the left side
-- |---|---|---|
-- |   X   |   |
-- |---|---|---|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, ";", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = 2 * (max.w / 3)
  f.h = max.h
  win:setFrame(f)
end)

-- Three Columns - Window on the second and third columns starting from the left side
-- |---|---|---|
-- |   |   X   |
-- |---|---|---|
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "'", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 3)
  f.y = max.y
  f.w = 2 * (max.w / 3)
  f.h = max.h
  win:setFrame(f)
end)


