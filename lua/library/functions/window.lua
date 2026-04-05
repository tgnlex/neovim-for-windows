local m = {}
local icons = {}
local default = "[untitled]"
icons.on = "◈ "
icons.off = ""

local function extract (win)
  local b = vim.api.nvim_win_get_buf(win)
  local fullname = vim.api.nvim_buf_get_name(b)
  local mod = vim.api.nvim_buf_get_option(b, 'modified') and icons.on or icons.off
  if fullname ~= "" then 
    local shortname = vim.fn.fnamemodify(fullname, ":~:.:gs%(.?[^/])[^/]*/%\1/%")
    if #shortname > 30 then shortname = vim.fn.fnamemodify(fullname, ":t") end
    return mod..shortname
  end
end


m.is_float = function(win)
  local config = vim.api.nvim_win_get_config(win)
  return config.zindex and config.zindex > 0
end


m.get_best = function(tabpage, window)
  local filename = extract(window)
  if filename == nil then 
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
      if #wins > i then 
        for _, win in ipairs(wins) do 
          filename = extract(win)
          break
        end
      end
    end
    if filename == nil then 
      return default
    end
    return filename
  end

return m;
