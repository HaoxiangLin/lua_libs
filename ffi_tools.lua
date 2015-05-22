-- chrislhx  at gmail.com

local ffi = require("ffi")

ffi.cdef[[
  char * strtok ( char * str, const char * delimiters );
]]

function string.split_tab(line)
  local c={}
  local len = line:len()  -- line is chop by lua, so need to add 1 to include "\0"?
  local line_c = ffi.new("char [?]", len + 1)
  ffi.copy(line_c,line,len)
  table.insert(c,ffi.string(ffi.C.strtok (line_c,"\t")))
  len = len - (c[#c]:len() + 1) -- include the delimiters
  while len > 0 do
     table.insert(c,ffi.string(ffi.C.strtok (NULL,"\t")))
     len = len - (c[#c]:len() + 1)
  end
  return c
end

