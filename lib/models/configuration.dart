// ignore_for_file: prefer_final_fields
class Configuration {
  String label;

  Configuration({required this.label});
}

class ConfigurationOperations {
  List<Configuration> getConfiguration() {
    return <Configuration>[
      Configuration(label: 'Account'),
      Configuration(label: 'Data Saver'),
      Configuration(label: 'Languages'),
      Configuration(label: 'Devices'),
      Configuration(label: 'Car'),
      Configuration(label: 'Voice Assistans & Apps'),
      Configuration(label: 'Video Quality'),
      Configuration(label: 'Storage'),
      Configuration(label: 'Notifications'),
      Configuration(label: 'Advertisements'),
      Configuration(label: 'Local Files'),
      Configuration(label: 'About'),
    ];
  }
}

class ConfigurationArtist {
  String label;

  ConfigurationArtist({required this.label});
}

class ConfigurationArtistOperations {
  List<ConfigurationArtist> _list = [
    ConfigurationArtist(label: 'Add new artist'),
    ConfigurationArtist(label: 'Delete existing artist'),
    ConfigurationArtist(label: 'Edit existing artist'),
  ];

  List<ConfigurationArtist> get artistConfigurations => _list;
}
