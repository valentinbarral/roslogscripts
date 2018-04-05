#!/bin/zsh

shopt -s nullglob
for bagFile in *.bag;
do
	echo "Processing $bagFile file..."

	filename=$(basename "$bagFile")
	extension="${filename##*.}"
	filename="${filename%.*}"

	logDuration="$(rosbag info ${bagFile} -k duration -y)"
	logDuration="$((${logDuration} + 4.0))"
	echo "Log duration: $logDuration"

	#Only UWB
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=0 use_px4:=0 use_mag:=0 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}

	#UWB + IMU
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=1 use_px4:=0 use_mag:=0 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_i_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}


	#UWB + MAG
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=0 use_px4:=0 use_mag:=1 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_m_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}


	#UWB + PX4
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=0 use_px4:=1 use_mag:=0 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_p_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}


	#UWB + IMU + MAG
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=1 use_px4:=0 use_mag:=1 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_i_m_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors  --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}

	#UWB + IMU + PX4
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=1 use_px4:=1 use_mag:=0 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_i_p_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors  --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}


	#UWB + MAG + PX4
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=0 use_px4:=1 use_mag:=1 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_m_p_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors  --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}

	#UWB + IMU + MAG + PX4
	roslaunch gtec_roskfpos kfpos_with_args.launch use_uwb:=1 use_imu:=1 use_px4:=1 use_mag:=1 &
	roslaunchPid=$!
	newRecordFilename="${filename}_u_i_m_p_a6_pos"
	echo "Generating  $newRecordFilename file..."
	rosbag record /gtec/kfpos /gtec/gazebo/pos /gtec/gazebo/anchors  --output-name=${newRecordFilename} -q --duration=${logDuration} &
	recordPid=$!
	rosbag play $bagFile -q &
	playPid=$!

	wait ${playPid}
	kill -9 ${roslaunchPid}




	# splitFilename="${filename}_u_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging"'

	# splitFilename="${filename}_u_i_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu"'

	# splitFilename="${filename}_u_m_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/mag"'

	# splitFilename="${filename}_u_p_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/px4flow"'

	# splitFilename="${filename}_u_i_m_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/erle/mag"'

	# splitFilename="${filename}_u_i_p_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/px4flow"'

	# splitFilename="${filename}_u_m_p_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/px4flow" or topic=="/gtec/gazebo/erle/mag"'

	# splitFilename="${filename}_u_i_m_p_a6.$extension"
	# rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/erle/mag" or topic=="/gtec/gazebo/px4flow"'

done