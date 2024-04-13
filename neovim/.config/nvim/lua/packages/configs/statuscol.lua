local builtin = require('statuscol.builtin')

require('statuscol').setup({
  segments = {
    { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
    {
      sign = {
        name = { 'Diagnostic' },
        maxwidth = 1,
        colwidth = 1,
        auto = true,
      },
    },
    {
      sign = {
        namespace = { 'gitsign' },
        maxwidth = 1,
        colwidth = 1,
        auto = true,
      },
    },
    { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
  },
})
