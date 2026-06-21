require("DEVELOP.DA.FFMPEG.ffmpeg")
require("DEVELOP.DA.MPV.mpv")

testFFMPEG() -- Call the test function from ffmpeg.lua
testMPV() -- Call the test function from mpv.lua

local filePath = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\[DB]Made in Abyss Movie - 01 - Tabidachi no Yoake_-_(Dual Audio_10bit_BD1080p_x265).mkv"
local subtitlePath = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\[DB]Made in Abyss Movie - 01 - Tabidachi no Yoake_-_(Dual Audio_10bit_BD1080p_x265).smi"
local convertedSubtitle = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\output.srt"

-- ffmpeg 변환 실행
os.execute("ffmpeg -i \"" .. subtitlePath .. "\" \"" .. convertedSubtitle .. "\"")
os.execute("start mpv --sub-file=\"" .. convertedSubtitle .. "\" \"" .. filePath .. "\"")
