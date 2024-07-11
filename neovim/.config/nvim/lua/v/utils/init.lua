return setmetatable({}, {
  __index = function(self, key)
    self[key] = require('v.utils.' .. key)
    return self[key]
  end,
})
