-- IF YOU DONT SEE THE MESSEGE INGAME THAT MEANS THE THE SONG NAME IS NOT REAL JUST CHECK THE .JSON FILE AND SEE WHAT IT NAME IS REALY IS
-- btw to change the font it has to be in the source code its in assets/shared/fonts :(


function onCreatePost()
-- For testing purposes The image is just one color but you can change it to be an image but then you need to mess with the x and y and more stuff

    makeLuaText("Maker", '', 0, 25, 25)
    makeLuaText("Charter", "man", 0, 25, 75)
    setTextSize("Maker", 27)
    setTextFont("Maker", "vcr.ttf");
    setTextSize("Charter", 25)
    setTextFont("Charter", "vcr.ttf");
    makeLuaSprite("Disk", "other/disk", -100, 0)
    scaleObject('Disk', 0.4, 0.4);
    makeLuaSprite('Image',"other/Image", 0, 0)
    --makeGraphic('Image', 2400, 150, '00A6FF') --azul 00A6FF rosa FF6ECC
    makeLuaSprite('Image2', 0, 0)
    makeGraphic('Image2', 2400, 150, '000000')
    makeLuaSprite('Icon2', 'other/icons/'..getProperty('iconP1.char'), 325,0)
    scaleObject('Icon2', 0.6, 0.6);

    setProperty('Maker.y', 330);
    setProperty('Charter.y', 370); --este va 50 mas 
    setProperty('Disk.y', 338);
    setProperty('Image.y', 300);
    setProperty('Image2.y', 290);
    setProperty('Icon2.y', 360);
-- Put the camera they will be in
    setObjectCamera("Maker", "other")
    setObjectCamera("Charter", "other")
    setObjectCamera('Disk', 'other')
    setObjectCamera('Image2', 'other')
    setObjectCamera('Image', 'other')
    setObjectCamera('Icon2', 'other')
-- order of that they will be displayed in
    setObjectOrder('Icon2', 5)
    setObjectOrder('Maker', 4)
    setObjectOrder('Charter', 4)
    setObjectOrder('Disk', 3)
    setObjectOrder('Image2', 2)
    setObjectOrder('Image', 1)
-- Mix The stuff togheter
    addLuaSprite("Disk")
    addLuaText("Maker")
    addLuaText("Charter")
    addLuaSprite("Image")
    addLuaSprite("Image2")
    addLuaSprite('Icon2')
-- Go out when the song starts just to come back when it starts. use your brain to caculate where they will go
-- so if the bg or here "Image" x is going to -500 and the text x is in 50 so you do -500+25 and thats -475 you do that so you wouldnt have delay belive me in the first version they were all going to -500
    doTweenX("Slideoutstart1", "Image", -2480, 0.1, linear)
    doTweenX("Slideoutstart2", "Image2", -2500, 0.1, linear)
    doTweenX("Slideoutstart3", "Maker", -475, 0.1, linear)
    doTweenX("Slideoutstart4", "Charter", -475, 0.1, linear)
    doTweenX("Slideoutstart5", "Disk", -1175, 0.1, linear)
    doTweenX("Slideoutstart5", "Icon2", -175, 0.1, linear)

    setTextString("Maker", 'Now Playing  :  ' ..songName)
    setTextString("Charter", "By: KawaiSprite")
end





function onSongStart()
        if songName == "Satin Panties C" then
            SongCharter = "JADS"
            setTextSize("Maker", 23)
        end
        if songName == "High C" then
         SongCharter = "Rozebud"
        end
        if songName == "Milf C" then
            SongCharter = "Rozebud"
        end

    setTextString("Charter", "By: " .. SongCharter)
end

function onStepHit()
-- Make it slide in and out
    if curStep == 3 then
        doTweenX("ImageTweenX", "Image", -120, 2.6, 'expoOut')
        doTweenX("Image2TweenX", "Image2", -100, 3.1, 'expoOut')
        doTweenX("SlideIn3", "Maker", 465, 2.3, 'expoOut')
        doTweenX("SlideIn4", "Charter", 465, 2.3, 'expoOut')
        doTweenX("SlideIn6", "Icon2", 660, 2, 'expoOut')
        doTweenAngle("Spin", "Disk", 2000, 10, 'expoOut')
    end
    if curStep == 4 then
        doTweenX("SlideIn5", "Disk", 390, 2.7, 'expoOut')
    end
    if curStep == 25 then
        doTweenX("SlideOut3", "Maker", 1775, 2, 'expoIn')
        doTweenX("SlideOut4", "Charter", 1775, 2, 'expoIn')
        doTweenX("SlideOut6", "Icon2", 2075, 2, 'expoIn')
    end
    if curStep == 26 then
        doTweenX("ImageTweenX", "Image", 1400, 2.9, 'expoIn')
        doTweenX("Image2TweenX", "Image2", 1400, 2.6, 'expoIn')
        doTweenX("SlideOut5", "Disk", 2075, 2, 'expoIn')
    end
end

function onTweenComplete(tag)
    if tag == "Spin" then
        removeLuaSprite("Image")
        removeLuaSprite("Image2")
        removeLuaSprite("Maker")
        removeLuaSprite("Charter")
        removeLuaSprite("Disk")
        removeLuaSprite("Icon2")
    end
end

function onUpdatePost()
    setProperty('Image.color', getIconColor('dad'))
end

function onEvent(name, value1, value2)
    if string.lower(name) == "change character" then
        if tonumber(value1) == 1 then
            setProperty('Image.color', getIconColor('dad'))
        end
    end
end

function getIconColor(chr)
    local chr = chr or "dad"
    return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end

function rgbToHex(array)
    return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
-- made by ramatia_yes@ adn ryan_sdjr :3