function egrep --wraps='command grep -E' --description 'alias egrep=command grep -E'
  command grep -E $argv; 
end
