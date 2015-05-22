#!/home/linhx/luajit
-- chrislhx  at gmail.com
--  Some tools used in daily work
--[[
    some IMPROTANT nots
         I can write
         funtion class_name.functioname(var1,var2)
         or
         function class_name.functioname(self,var2)
         or
         function functioname(var1,var2)
         or
         functio class_name:functioname(var2)   self auto load into the program


         when use no matther how u write the function:
         var1:functioname(var2)
         or
         class_name.functioname(var1,var2)
]]--

-- BE careful!  don't use a var name the same as the class name, for example the table, if u define one it will make the class be null
-- Also it seems I can add the function to the table but can't using the class:fun mode if the class is table, for some reasons? because using the talbe  to simulate the class?
------------------------------------------------------------
-- cut > awk
-- regex > split

function string.split(line)
  local c={}
  local buff=nil
  for buff in string.gmatch(line, "[^%s]+") do
      table.insert(c,buff)
  end
  return c
end

function string.split_tab(line)
  local c={}
  local buff=nil
  for buff in string.gmatch(line, "[^\t]+") do
      table.insert(c,buff)
  end
  return c
end

function string.split_delim(line,delimiter)
  local c={}
  local buff=nil
  for buff in string.gmatch(line, "[^"..delimiter.."]+") do
      table.insert(c,buff)
  end
  return c
end

function table.size(self)
  local n = 0
  local k=nil
  local v=nil
  for k, v in pairs(self) do
     n = n + 1
  end
  return n
end
function baseName(str)
    return string.match (str,"/([^/]+)$")
end


function table:print()
   for k, v in pairs(self) do
     print (k.."->"..v)
   end
end
function fopen(file)
   local IN=nil
   if file == '-' then
      IN=assert(io.open("/dev/stdin"))
   elseif string.match(file,"%.gz$") then
      IN=assert(io.popen("gzip -dc "..file))
   else
      IN=assert(io.open(file))
   end
   return IN
end
function basename(path)
  return string.match(path,"[^/]+$")
end
function fwrite(file)
   local OT=nil
   if string.match(file,"%.gz$") then
      OT=assert(io.popen("gzip -c > "..file,"w"))
   else
      OT=assert(io.open(file,"w"))
   end
   return OT
end
function basename(path)
  return string.match(path,"[^/]+$")
end

function usage(str,arg)
   local tbl=str:split()
   if arg[(table.size(tbl))] == nil then 
      io.stderr:write("usage: ")
      io.stderr:write (str)
		io.stderr:write("\n")
		os.exit(1)
   end
end

function printf(str,...)
  io.write(string.format(str,...))
end
function debug(tbl,msg)
   if msg == nil then
      io.stderr:write("[DEBUG] ",table.concat(tbl," "),"\n")
   else
      io.stderr:write("[",msg,"] ",table.concat(tbl," "),"\n")
   end
end

function getOpts(arg)
   local opts={}
   local key=nil
   for _,v in ipairs(arg) do
     if v:sub(1,1) == "-" then
         key=v:sub(2)
     else
         opts[key]=v
     end
   end
   return opts
end
function getSum(tbl) -- Total
   local sum=0
   for _,v in ipairs(tbl) do
       sum=sum+tonumber(v)
   end
   return sum
end
function getAvg(tbl) --average
   local size=table.size(tbl)
   return getSum(tbl)/size
end
function getMedian(tbl) --median
   local size=table.size(tbl)
   table.sort(tbl)
   if size%2 ~= 0 then
      return tbl[((size+1)/2)]
   else
      return (tbl[(size/2)]+tbl[(size/2)+1])/2
   end
end
function getVar(tbl) --variance
   local size=table.size(tbl)
   local avg=getSum(tbl)/size
   local sum=0
   for _,v in ipairs(tbl) do
      sum=sum+(tonumber(v)-avg)^2
   end
   return sum/size
end
--for token in string.gmatch(line, "[^%s]+") do
  -- print(token)
  -- end

------------------------------------------------------------Main
--local line="read to work"
--out=split(line)

--print (table.concat(out,"\n"))
