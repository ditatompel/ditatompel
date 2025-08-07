-- Smart paste: paste files without entering the directory
--
-- See: https://yazi-rs.github.io/docs/tips#smart-paste

return {
  entry = function()
    local h = cx.active.current.hovered
    if h and h.cha.is_dir then
      ya.manager_emit('enter', {})
      ya.manager_emit('paste', {})
      ya.manager_emit('leave', {})
    else
      ya.manager_emit('paste', {})
    end
  end,
}

-- vim: ts=2 sts=2 sw=2 et
