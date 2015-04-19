local ssloader = {}

function ssloader.load(dir)
  local files = love.filesystem.getDirectoryItems( dir )
  ssloader.img = {}
  ssloader.data = {}
  for i,v in pairs(files) do
    local d = string.match(v,'ss%-(%d+)%.png')
    if d then
      local json_file = dir..'ss-'..d..'.json'
      --print("loading",dir..v)
      ssloader.img[d] = love.graphics.newImage(dir..v)
      --print("loading",json_file)
      local json_raw = love.filesystem.read(json_file)
      local json_data = json.decode(json_raw)
      ssloader.data[d] = json_data
    end
  end
end

function ssloader.lookup(name)
  for isheet,vsheet in pairs(ssloader.data) do
    for isprite,vsprite in pairs(vsheet.sprites) do
      if isprite == name then
        local quad = love.graphics.newQuad(
          vsprite.x,vsprite.y,
          vsprite.width,vsprite.height,
          vsheet.width,vsheet.height)
        return ssloader.img[isheet],quad,vsprite
      end
    end
  end
end

return ssloader
