-- xmonad config file by Skye

-- imports
import XMonad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- terminal
myTerminal      = "st"

-- focus follows mouse
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- cliking to focus also clicks or just focuses
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- window border in pixels
myBorderWidth   = 2

-- mod1Mask = left alt, mod4Mask = win key
myModMask       = mod1Mask

-- workspace names
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- border colors
myNormalBorderColor  = "white"
myFocusedBorderColor = "#C97799"

-- key bindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm .|. shiftMask, xK_Return), spawn "dmenu_run")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    -- reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- swap the focused window and the master window
    , ((modm .|. shiftMask, xK_m     ), windows W.swapMaster)

    -- swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    -- mod-[1..9], switch to workspace N
    -- mod-shift-[1..9], move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


-- mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster)) ]

-- layouts
myLayoutHook = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- the default number of windows in the master pane
     nmaster = 1

     -- default proportion of screen occupied by master pane
     ratio   = 1/2

     -- percent of screen to increment by when resizing panes
     delta   = 3/100

-- window rules
myManageHook = composeAll
    [ className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- event handling
myEventHook = mempty

-- startup hook
myStartupHook = do
        spawnOnce "feh --bg-fill -z /home/skye/wallpapers/*/* &"
        spawnOnce "picom &"

-- run xmonad with the settings specified
main = do
        xmproc <- spawnPipe "xmobar -x 0 /home/skye/.config/xmobar/xmobar.config"
        xmonad $ docks def
		{ terminal 		= myTerminal
		, focusFollowsMouse 	= myFocusFollowsMouse
		, clickJustFocuses   	= myClickJustFocuses
		, borderWidth        	= myBorderWidth
		, modMask            	= myModMask
		, workspaces         	= myWorkspaces
		, normalBorderColor  	= myNormalBorderColor
		, focusedBorderColor 	= myFocusedBorderColor
		
		, keys		= myKeys
		, mouseBindings	= myMouseBindings

		, manageHook = myManageHook
		, layoutHook = myLayoutHook
		, handleEventHook = myEventHook
		, startupHook = myStartupHook
		, logHook    = dynamicLogWithPP xmobarPP
				{ ppOutput = hPutStrLn xmproc
				, ppTitle = xmobarColor "#C97799" "" . shorten 50
				, ppCurrent = xmobarColor "#C97799" "" . wrap "<" ">"
				, ppVisible = xmobarColor "#D6B6CA" "" . wrap "[" "]"
				, ppHidden = xmobarColor "#D6B6CA" "" . wrap "*" ""
				, ppSep = " | "
				}
		}

