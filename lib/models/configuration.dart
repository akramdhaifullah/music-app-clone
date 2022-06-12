import 'package:flutter/cupertino.dart';

class Configuration {
  String configName;

  Configuration({required this.configName});
}

class ConfigurationOperations {
  List<Configuration> getConfiguration() {
    return <Configuration>[
      Configuration(configName: 'Account'),
      Configuration(configName: 'Data Saver'),
      Configuration(configName: 'Languages'),
      Configuration(configName: 'Devices'),
      Configuration(configName: 'Car'),
      Configuration(configName: 'Voice Assistans & Apps'),
      Configuration(configName: 'Video Quality'),
      Configuration(configName: 'Storage'),
      Configuration(configName: 'Notifications'),
      Configuration(configName: 'Advertisements'),
      Configuration(configName: 'Local Files'),
      Configuration(configName: 'About'),
    ];
  }
}
