local cmp = require('cmp')

cmp.setup({
  performance = {
    async_budget = 64,
    max_view_entries = 64,
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = {
      ['c'] = cmp.mapping.select_prev_item(),
      ['i'] = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end,
    },
    ['<C-n>'] = {
      ['c'] = cmp.mapping.select_next_item(),
      ['i'] = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end,
    },
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<PageDown>'] = cmp.mapping(
      cmp.mapping.select_next_item({
        count = vim.o.pumheight ~= 0 and math.ceil(vim.o.pumheight / 2) or 8,
      }),
      { 'i', 'c' }
    ),
    ['<PageUp>'] = cmp.mapping(
      cmp.mapping.select_prev_item({
        count = vim.o.pumheight ~= 0 and math.ceil(vim.o.pumheight / 2) or 8,
      }),
      { 'i', 'c' }
    ),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-w>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<C-y>'] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      { 'i', 'c' }
    ),

    ['<Tab>'] = {
      ['c'] = function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end,
      ['i'] = function(fallback)
        if vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end,
    },
    ['<S-Tab>'] = {
      ['c'] = function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end,
      ['i'] = function(fallback)
        if vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end,
    },
  },
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp', max_item_count = 20 },
    {
      name = 'buffer',
      max_item_count = 8,
    },
    { name = 'path' },
    { name = 'calc' },
  },
  window = {
    documentation = {
      max_width = 80,
      max_height = 20,
      border = 'solid',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, cmp_item)
      cmp_item.kind = entry.source.name == 'calc' and icons.ui.Calculator or icons.kinds[cmp_item.kind] or '  '

      return cmp_item
    end,
  },
})

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  enabled = true,
  sources = { { name = 'buffer' } },
})
cmp.setup.cmdline('?', {
  enabled = true,
  sources = { { name = 'buffer' } },
})
-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  enabled = true,
  sources = {
    {
      name = 'path',
      group_index = 1,
    },
    {
      name = 'cmdline',
      option = {
        ignore_cmds = {},
      },
      group_index = 2,
    },
  },
})

cmp.setup.cmdline('@', { enabled = false })
cmp.setup.cmdline('>', { enabled = false })
cmp.setup.cmdline('-', { enabled = false })
cmp.setup.cmdline('=', { enabled = false })
