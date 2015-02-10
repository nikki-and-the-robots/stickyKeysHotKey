
#include <stdio.h>
#include <windows.h>

int c_getHotKeyActive() {
    STICKYKEYS stickyKeys;
    stickyKeys.cbSize = sizeof(STICKYKEYS);
    SystemParametersInfo(SPI_GETSTICKYKEYS, 0, &stickyKeys, 0);
    return (stickyKeys.dwFlags & SKF_HOTKEYACTIVE);
};

void c_setHotKeyActive(int status) {
    STICKYKEYS stickyKeys;
    stickyKeys.cbSize = sizeof(STICKYKEYS);
    SystemParametersInfo(SPI_GETSTICKYKEYS, 0, &stickyKeys, 0);
    if (status) {
        stickyKeys.dwFlags = stickyKeys.dwFlags | SKF_HOTKEYACTIVE;
    } else {
        stickyKeys.dwFlags = stickyKeys.dwFlags & ~SKF_HOTKEYACTIVE;
    }
    SystemParametersInfo(SPI_SETSTICKYKEYS, 0, &stickyKeys, 0);
};

