local sfxclass = {}

sfxclass.data = {
  attack = {
    love.audio.newSource("assets/sfx/attack.wav","static"),
  },
  bread_hurt = {
    love.audio.newSource("assets/sfx/bread_hurt.wav","static"),
  },
  dino_hurt = {
    love.audio.newSource("assets/sfx/dino_hurt.wav","static"),
  },
  failure = {
    love.audio.newSource("assets/sfx/failure.wav","static"),
  },
  success = {
    love.audio.newSource("assets/sfx/success.wav","static"),
  },
  jump = {
    love.audio.newSource("assets/sfx/jump.wav","static"),
  },
  land = {
    love.audio.newSource("assets/sfx/land.wav","static"),
  }
}

function sfxclass:play(sfx_name)
  print("Playing",sfx_name)
  if self.data[sfx_name] then
    local sound = self.data[sfx_name][math.random(1,#self.data[sfx_name])]
    if sound:isPlaying() then
      sound:stop()
    end
    sound:play()
  else
    print("Warning: This sound does not exist.")
  end
end

return sfxclass
