import { NativeModules, Platform } from "react-native";

const { PassLibrary } = NativeModules;

const passLibrary = () => {
  switch (Platform.OS) {
    case "ios":
      return PassLibrary;
    default:
      return {};
  }
};

const library = passLibrary();

export default library;
