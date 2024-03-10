local cmp = require('cmp')

---HACK: `nvim_lsp` and `nvim_lsp_signature_help` source still use
---deprecated `vim.lsp.buf_get_clients()`, which is slower due to
---the deprecation and version check in that function. Overwrite
---it using `vim.lsp.get_clients()` to improve performance.
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.buf_get_clients(bufnr)
  return vim.lsp.get_clients({ buffer = bufnr })
end

local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match('%s')
      == nil
end

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
  mapping = cmp.mapping.preset.insert({
    -- ['<S-Tab>'] = {
    --   ['c'] = function()
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --     else
    --       cmp.complete()
    --     end
    --   end,
    --   ['i'] = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --     elseif vim.snippet.jumpable(-1) then
    --       vim.snippet.jump(-1)
    --     else
    --       fallback()
    --     end
    --   end,
    -- },
    -- ['<Tab>'] = {
    --   ['c'] = function()
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --     else
    --       cmp.complete()
    --     end
    --   end,
    --   ['i'] = function(fallback)
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --     elseif vim.snippet.jumpable(1) then
    --       vim.snippet.jump(1)
    --     elseif has_words_before() then
    --       cmp.complete()
    --     else
    --       fallback()
    --     end
    --   end,
    -- },
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-Space>'] = cmp.mapping.complete(),

    ['<Tab>'] = cmp.mapping(function()
      if vim.snippet.jumpable(1) then
        vim.snippet.jump(1)
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function()
      if vim.snippet.jumpable(-1) then
        vim.snippet.jump(-1)
      end
    end, { 'i', 's' }),
  }),
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
    completion = {
      scrolloff = 3,
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
      cmp_item.kind = entry.source.name == 'calc' and icons.ui.Calculator
        or icons.kinds[cmp_item.kind]
        or ''
      return cmp_item
    end,
  },
})
