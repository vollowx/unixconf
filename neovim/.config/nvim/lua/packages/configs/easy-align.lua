vim.g.easy_align_delimiters = {
  ['\\'] = {
    pattern = [[\\\+]],
  },
  ['/'] = {
    pattern = [[//\+\|/\*\|\*/]],
    delimiter_align = 'c',
    ignore_groups = '!Comment',
  },
}
