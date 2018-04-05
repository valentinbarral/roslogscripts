# README

This project contains two scripts to handle ROS bags.

## split_logs.sh

Generates ROS bags with different sensor configurations from an original .bag file:

The follow logs are created:

- Name_u_a6.bag: only UWB
- Name_u_i_a6.bag: UWB + IMU
- Name_u_m_a6.bag: UWB + MAG
- Name_u_p_a6.bag: UWB + PX4FLow
- Name_u_i_m_a6.bag: UWB + IMU + MAG
- Name_u_i_p_a6.bag: UWB + IMU + PX4FLow
- Name_u_m_p_a6.bag: UWB + MAG + PX4FLow
- Name_u_i_m_p_a6.bag: UWB + IMU + MAG + PX4FLow

### Use:
```bash
$ ./split_logs.sh
```

inside the folder with the original ```.bag```  files.

## record_with_pos.sh 

Launches at the same time a play of a record with data from sensors and an instance of the ```kfpos``` node to record a new bag including the new position estimations.

The script performs the next steps: 

- Launches ```kfpos``` node
- Wait 2 seconds
- Launches ```rosbag record```
- Launches ```rosbag play``` with a bag that contains data from sensors.
- Waits until ```rosbag play``` ends.
- Kills ```rosbag record``` process.
- Kills ```kfpos``` node.
- Repeat.

Output bags have a name like:  ```Name_pos.bag```


### Use:

```bash
$ ./record_with_pos.sh
```

inside a folder containing at least one ```.bag```  file with data from sensors. If there are several ```.bag``` files, all of them are processed sequentially.