function gc --wraps='git commit -asS' --description 'alias gc=git commit -asS'
  if not string match -e $PWD $gc_nosignoff_paths
    git commit -asS $argv;
  else
    git commit -aS $argv;
  end
end
