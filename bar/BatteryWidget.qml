import Quickshell.Services.UPower
import "../components/"
import "../style/"

MyButton {
  height: 24
  visible: UPower.displayDevice.isLaptopBattery
  label: {
    let batteryIcon = "";
    const battery = Math.trunc(UPower.displayDevice.percentage * 100);
    switch (UPower.displayDevice.state) {
    case UPowerDeviceState.Charging:
      {
        if (battery < 10) {
          batteryIcon = "󰢟";
        } else if (battery < 20) {
          batteryIcon = "󰢜";
        } else if (battery < 30) {
          batteryIcon = "󰂆";
        } else if (battery < 40) {
          batteryIcon = "󰂇";
        } else if (battery < 50) {
          batteryIcon = "󰂈";
        } else if (battery < 60) {
          batteryIcon = "󰢝";
        } else if (battery < 70) {
          batteryIcon = "󰂉";
        } else if (battery < 80) {
          batteryIcon = "󰢞";
        } else if (battery < 90) {
          batteryIcon = "󰂊";
        } else if (battery < 100) {
          batteryIcon = "󰂋";
        }
        break;
      }
    case UPowerDeviceState.Discharging:
      {
        if (battery < 10) {
          batteryIcon = "󰂎";
        } else if (battery < 20) {
          batteryIcon = "󰁺";
        } else if (battery < 30) {
          batteryIcon = "󰁻";
        } else if (battery < 40) {
          batteryIcon = "󰁼";
        } else if (battery < 50) {
          batteryIcon = "󰁽";
        } else if (battery < 60) {
          batteryIcon = "󰁾";
        } else if (battery < 70) {
          batteryIcon = "󰁿";
        } else if (battery < 80) {
          batteryIcon = "󰂀";
        } else if (battery < 90) {
          batteryIcon = "󰂁";
        } else if (battery < 100) {
          batteryIcon = "󰂂";
        }
        break;
      }
    case UPowerDeviceState.FullyCharged:
      {
        return "󰂅";
      }
    }
    return battery + "% " + batteryIcon;
  }
  color: {
    switch (UPower.displayDevice.state) {
    case UPowerDeviceState.Charging:
      {
        return Theme.green;
      }
    case UPowerDeviceState.Discharging:
      {
        const battery = Math.trunc(UPower.displayDevice.percentage * 100);
        if (battery < 15) {
          return Theme.red;
        }
        if (battery < 30) {
          return Theme.peach;
        }
        return Theme.yellow;
      }
    case UPowerDeviceState.FullyCharged:
      {
        return Theme.lavender;
      }
    }
    return "red";
  }
  labelColor: Theme.crust
}
