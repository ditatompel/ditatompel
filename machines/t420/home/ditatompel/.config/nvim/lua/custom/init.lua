vim.opt.colorcolumn = "80"

-- invisible chars
vim.opt.listchars = {
  --space = "•",
  tab = ">·",
  trail = "•",
}
vim.opt.list = true
vim.wo.relativenumber = true

-- Stop characters deleted in normal mode being added to the clip board
-- https://github.com/NvChad/NvChad/issues/1150#issuecomment-1140557669
vim.cmd [[ 
  nnoremap d "_d
  vnoremap d "_d
]]
