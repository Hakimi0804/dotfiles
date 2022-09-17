function cat --wraps='bat --style=changes,header,rule,numbers,snip --wrap=never' --description 'alias cat=bat --style=changes,header,rule,numbers,snip --wrap=never'
  bat --style=changes,header,rule,numbers,snip $argv; 
end
