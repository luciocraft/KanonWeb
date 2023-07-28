--data/'song'/

function onCreate()
    --Sprites mods/characters
    setPropertyFromClass('GameOverSubstate', 'characterName', 'Dpico')
    --Death sound mods/sounds
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'picod')
    --Dead music mods/music
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'picoo')
    --Retry sound mods/music
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'picoo-end')
end