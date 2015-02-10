{-# language ForeignFunctionInterface, CPP #-}

-- | This module can be used to get and set
-- STICKYKEYS.SKF_HOTKEYACTIVE on windows.
-- If set to True, pressing shift five
-- times will result in a window popping up
-- asking whether to activate the sticky keys
-- feature.
--
-- On other platforms, all functions have no
-- effect but can be used riskless.

module System.Win32.StickyKeysHotKey where


import Control.Applicative
import Control.Exception


#ifdef mingw32_HOST_OS

-- | Returns the current state of STICKYKEYS.SKF_HOTKEYACTIVE.
foreign import ccall unsafe "c_getHotKeyActive" getHotKeyActive
    :: IO Bool

-- | Sets the current state of STICKYKEYS.SKF_HOTKEYACTIVE.
foreign import ccall unsafe "c_setHotKeyActive" setHotKeyActive
    :: Bool -> IO ()

-- | Sets STICKYKEYS.SKF_HOTKEYACTIVE to False during the
-- execution of the given command. Resets the original state
-- afterwards
withHotKeyDeactivated :: IO a -> IO a
withHotKeyDeactivated cmd =
    bracket
        (getHotKeyActive <* setHotKeyActive False)
        setHotKeyActive
        (const cmd)

#else

-- | Returns the current state of STICKYKEYS.SKF_HOTKEYACTIVE.
getHotKeyActive :: IO Bool
getHotKeyActive = return False

-- | Sets the current state of STICKYKEYS.SKF_HOTKEYACTIVE.
setHotKeyActive :: Bool -> IO ()
setHotKeyActive = const $ return ()

-- | Sets STICKYKEYS.SKF_HOTKEYACTIVE to False during the
-- execution of the given command. Resets the original state
-- afterwards
withHotKeyDeactivated :: IO a -> IO a
withHotKeyDeactivated = id

#endif
