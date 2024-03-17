local cmp = require('cmp')

---HACK: `nvim_lsp` and `nvim_lsp_signature_help` source still use
---deprecated `vim.lsp.buf_get_clients()`, which is slower due to
---the deprecation and version check in that function. Overwrite
---it using `vim.lsp.get_clients()` to improve performance.
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.buf_get_clients(bufnr)
  return vim.lsp.get_clients({ buffer = bufnr })
end

cmp.setup({
  experimental = { ghost_text = true },
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
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<C-l>'] = cmp.mapping(function()
      if vim.snippet.jumpable(1) then
        vim.snippet.jump(1)
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if vim.snippet.jumpable(-1) then
        vim.snippet.jump(-1)
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lsp', max_item_count = 20 },
    { name = 'copilot' },
    {
      name = 'buffer',
      max_item_count = 8,
    },
    { name = 'path' },
    { name = 'calc' },
  },
  window = {
    completion = {
      col_offset = -3,
      scrolloff = 3,
      side_padding = 0,
    },
    documentation = {
      max_width = 80,
      max_height = 20,
      border = 'solid',
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, cmp_item)
      cmp_item.menu = cmp_item.kind
      cmp_item.kind = ' '
        .. (
          entry.source.name == 'calc' and icons.ui.Calculator
          or icons.kinds[cmp_item.kind]
          or '  '
        )
      return cmp_item
    end,
  },
})
