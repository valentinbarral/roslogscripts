#!/bin/zsh
topics_to_record=("/gtec/vr/pos" "/raspicam_node/image/compressed" "/px4flow/px4flow/raw/optical_flow_rad" "/gtec/toa/anchors" "/gtec/toa/ranging")

if [ "$#" -ne 3 ]; then
    echo "Use: ./record_robot_sensors basename num_reps rep_duration"
    exit 1
fi

filename=$1
num_reps=$2
logDuration=$3

num_reps=$(expr ${num_reps} - 1)

for runIndex in {0..${num_reps}}
do
  current_date=$(date +%d%m%y_%H%M%S)
  newRecordFilename="${filename}_${runIndex}_${current_date}"
  rosbag record ${topics_to_record} --output-name=${newRecordFilename} -q --duration=${logDuration}
done

