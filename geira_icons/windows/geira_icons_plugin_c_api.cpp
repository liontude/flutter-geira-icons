#include "include/geira_icons/geira_icons_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "geira_icons_plugin.h"

void GeiraIconsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  geira_icons::GeiraIconsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
