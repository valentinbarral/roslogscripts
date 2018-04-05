#!/bin/bash

shopt -s nullglob
for bagFile in *.bag;
do
	echo "Processing $bagFile file..."

	filename=$(basename "$bagFile")
	extension="${filename##*.}"
	filename="${filename%.*}"

	splitFilename="${filename}_u_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging"'

	splitFilename="${filename}_u_i_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu"'

	splitFilename="${filename}_u_m_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/mag"'

	splitFilename="${filename}_u_p_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/px4flow"'

	splitFilename="${filename}_u_i_m_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/erle/mag"'

	splitFilename="${filename}_u_i_p_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/px4flow"'

	splitFilename="${filename}_u_m_p_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/px4flow" or topic=="/gtec/gazebo/erle/mag"'

	splitFilename="${filename}_u_i_m_p_a6.$extension"
	rosbag filter $bagFile $splitFilename 'topic=="/gtec/gazebo/pos" or topic=="/gtec/gazebo/anchors" or topic=="/gtec/toa/ranging" or topic=="/gtec/gazebo/erle/imu" or topic=="/gtec/gazebo/erle/mag" or topic=="/gtec/gazebo/px4flow"'

done