-- ===== OPTIONS =====
local thin = '*-Alt_L'
local tall = '*-F4'
local wide = '*-V'

local toggle_ninbot = '*-apostrophe'
local fullscreen = "Shift-O"

local normal_sens = 17.10193323
local tall_sens = 0.5


-- ===== SETUP =====
local waywall = require('waywall')
local helpers = require('waywall.helpers')

local config_path = os.getenv('HOME') .. '/.config/waywall/'
local measure_overlay_path = config_path .. 'measuring_overlay.png'

local function make_res(config)
  for _, mirror in pairs(config.mirrors or {}) do
    helpers.res_mirror(mirror, config.res.w, config.res.h)
  end

  for path, image in pairs(config.images or {}) do
    helpers.res_image(path, image, config.res.w, config.res.h)
  end
  
  return helpers.toggle_res(config.res.w, config.res.h, config.sens or normal_sens)
end


-- ===== RESOLUTIONS =====
local monitor_w = 2560
local monitor_h = 1600

local resolutions = {
  thin = make_res({
    res = { w = 340, h = monitor_h },
    mirrors = {
      entity_count = {
        src = { x = 0, y = 37, w = 85, h = 9 },
        dst = { x = 1130, y = 618, w = 4 * 85, h = 4 * 9 },
      },
    },
  }),

  tall = make_res({
    res = { w = 340, h = 16384 },
    sens = tall_sens,
    mirrors = {
      eye_measure = {
        src = { x = 155, y = 7902, w = 30, h = 580 },
        dst = { x = 0, y = 370, w = 790, h = 340 },
      },
      -- entity_count = {
      --   src = { x = 0, y = 37, w = 85, h = 9 },
      --   dst = { x = 1130, y = 618, w = 4 * 85, h = 4 * 9 },
      -- },
      -- pie = {
      --   src = { x = 0, y = 15958, w = 340, h = 426 },
      --   dst = { x = 1130, y = 800, w = 340, h = 426 },
      -- },
    },
    images = {
      [measure_overlay_path] = {
        dst = { x = 0, y = 370, w = 790, h = 340 },
      },
    },
  }),

  wide = make_res({
    res = { w = monitor_w, h = 340 },
  }),
}


-- ===== NinjaBrain Bot =====
local function nb_is_running()
  local handle = io.popen("pgrep -f 'NinjaBrain.*jar'")
  local result = handle:read("*l")
  handle:close()
  return result ~= nil
end

local function handle_toggle_ninbot()
  if nb_is_running() then
    waywall.toggle_floating()
  else
    waywall.exec('ninjabrainbot')
    waywall.show_floating(true)
  end
end

-- ===== WAYWALL =====
return {
  input = {
    layout = 'us',
    repeat_rate = 40,
    repeat_delay = 300,
    sensitivity = normal_sens,
  },
  theme = {
    background = '#00000000',
    ninb_anchor = 'topright',
    ninb_opacity = 1,
  },
  window = {
    fullscreen_width = monitor_w,
    fullscreen_height = monitor_h,
  },
  actions = {
    [thin] = resolutions.thin,
    [tall] = resolutions.tall,
    [wide] = resolutions.wide,

    [toggle_ninbot] = handle_toggle_ninbot,
  },
}

