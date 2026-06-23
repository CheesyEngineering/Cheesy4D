require("DEVELOP.DA.FFMPEG.ffmpeg")
require("DEVELOP.DA.MPV.mpv")

testFFMPEG() -- Call the test function from ffmpeg.lua
testMPV() -- Call the test function from mpv.lua
local ffi = require("ffi")
local filePath = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\[DB]Made in Abyss Movie - 01 - Tabidachi no Yoake_-_(Dual Audio_10bit_BD1080p_x265).mkv"
local subtitlePath = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\[DB]Made in Abyss Movie - 01 - Tabidachi no Yoake_-_(Dual Audio_10bit_BD1080p_x265).smi"
local convertedSubtitle = "C:\\Users\\Cathe.DESKTOP-15HC8CV\\Downloads\\Made in Abyss\\Made in Abyss Movies\\output.srt"

-- ffmpeg 변환 실행
-- os.execute("ffmpeg -i \"" .. subtitlePath .. "\" \"" .. convertedSubtitle .. "\"")
-- os.execute("start mpv --sub-file=\"" .. convertedSubtitle .. "\" \"" .. filePath .. "\"")


-- libmpv 함수 선언 (일부만)
ffi.cdef[[
typedef struct mpv_handle mpv_handle;
typedef struct mpv_event mpv_event;
typedef struct mpv_render_context mpv_render_context;

mpv_handle* mpv_create(void);
int mpv_initialize(mpv_handle* ctx);
int mpv_command(mpv_handle* ctx, const char** args);
int mpv_wait_event(mpv_handle* ctx, double timeout);
]]

local libmpv = ffi.load("libmpv") -- libmpv.dll 필요

local mpv = nil

function love.load()
    love.window.setMode(1920, 1080, {resizable=false})

    -- mpv 인스턴스 생성 및 초기화
    mpv = libmpv.mpv_create()
    libmpv.mpv_initialize(mpv)

    -- 영상 로드
    local args = ffi.new("const char*[3]", {"loadfile", "\"" .. filePath .. "\"", nil})
    libmpv.mpv_command(mpv, args)
end

function love.update(dt)
    -- mpv 이벤트 처리 (예: 종료 이벤트 감지)
    local ev = libmpv.mpv_wait_event(mpv, 0)
    -- 여기서 ev를 검사해서 quit 이벤트가 오면 love.event.quit() 호출 가능
end

function love.draw()
    -- TODO: mpv_render_context를 생성하고 OpenGL로 프레임 렌더링
    love.graphics.print("mpv 영상 출력 중...", 20, 20)
end
