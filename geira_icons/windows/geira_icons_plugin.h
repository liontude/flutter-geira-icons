#ifndef FLUTTER_PLUGIN_GEIRA_ICONS_PLUGIN_H_
#define FLUTTER_PLUGIN_GEIRA_ICONS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace geira_icons {

class GeiraIconsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  GeiraIconsPlugin();

  virtual ~GeiraIconsPlugin();

  // Disallow copy and assign.
  GeiraIconsPlugin(const GeiraIconsPlugin&) = delete;
  GeiraIconsPlugin& operator=(const GeiraIconsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace geira_icons

#endif  // FLUTTER_PLUGIN_GEIRA_ICONS_PLUGIN_H_
