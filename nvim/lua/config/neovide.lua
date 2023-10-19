-- https://neovide.dev/configuration.html
-- https://neovide.dev/faq.html
package.loaded['config.neovide'] = nil

if not vim.g.neovide then
  return
end
local M = {}

-- Font
M.font = {
  -- family = "SauceCodePro Nerd Font Mono",
  family = "JetBrainsMono Nerd Font Mono", linespace = -3,
  size = 16,
}

function M.font.sync(self)
  vim.o.guifont = string.format("%s:h%d%s",
    M.font.family,
    M.font.size,
    "")
  vim.o.linespace = self.linespace or 0
end
M.font:sync()

function M.font.adjust_size(self, adjust)
  vim.validate { adjust = { adjust, 'number' } }
  self.size = self.size + adjust
  self:sync()
end
function M.font.set_size(self, size)
  vim.validate { size = { size, 'number' } }
  self.size = size
  self:sync()
end


-- Sensible default keymaps (Cmd+... keys)
local ALL_MODES = { 'n', 'v', 'x', 's', 'o', 'i', 'l', 'c', 't' }

-- Cmd + V
vim.keymap.set({'i', 'c', 't'}, '<D-v>', '<Plug>(neovide-paste)', { remap = true })
vim.keymap.set({'i', 'c', 't'}, '<S-Insert>', '<Plug>(neovide-paste)', { remap = true })
vim.keymap.set({'i', 'c'}, '<Plug>(neovide-paste)', '<cmd>set paste<CR><C-r>+<cmd>set nopaste<CR>', { silent = true })
-- Cmd + {0, -, +}
vim.keymap.set(ALL_MODES, '<D-=>', function() M.font:adjust_size(1) end)
vim.keymap.set(ALL_MODES, '<D-->', function() M.font:adjust_size(-1) end)
vim.keymap.set(ALL_MODES, '<D-0>', function() M.font:set_size(16) end)


-- Appearances

return M