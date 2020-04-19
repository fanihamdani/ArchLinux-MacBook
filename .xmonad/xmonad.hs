import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Config.Gnome
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Spacing (smartSpacing)

main = xmonad def
    { terminal = "urxvt"
    , modMask = mod4Mask -- Use super instead of Alt
        , borderWidth        = myBorderWidth
        , focusedBorderColor = myFocusedBorderColor
        -- , normalBorderColor  = myNormalBorderColor
        , handleEventHook    = fullscreenEventHook
        -- , logHook            = myLogHook
        -- , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
}

-- width of border around windows
myBorderWidth        = 2

-- color of focused border
myFocusedBorderColor = "#000000"

-- color of inactive border
myNormalBorderColor  = "#cccccc"

-- removes borders in fullscreen mode
myLayoutHook         = smartSpacing 2 $ smartBorders (layoutHook gnomeConfig)

-- support xcompmgr events
myLogHook            = do
  logHook gnomeConfig
  fadeInactiveLogHook 0.4
        
{- startup command for window effects        
"-cfF" "c" is for soft shadows and transparency support, 
       "f" for fade in & fade out when creating and closing windows, 
       and "F" for fade when changing a window's transparency.
"-t-9 -l-11" shadows are offset 9 pixels from top of the window 
             and 11 pixels from the left edge
"-r9" shadow radius is 9 pixels
        
"-o.95" shadow opacity is set to 0.95
"-D6" the time between each step when fading windows is set to 6 milliseconds.
-}
myStartupHook        = do
  startupHook gnomeConfig
  spawn "xcompmgr -cfF -t-9 -l-11 -r9 -o.95 -D6 &"
  setWMName "LG3D"
