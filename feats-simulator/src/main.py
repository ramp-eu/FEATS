#!/usr/bin/env python

import rospy
from std_msgs.msg import String
from geometry_msgs.msg import PoseWithCovarianceStamped, Quaternion, Vector3

location = rospy.Publisher('/amcl_pose', PoseWithCovarianceStamped, queue_size=3)

status = rospy.Publisher('feats/status', String, queue_size=3)

def updateStatus(current):
    global STATUS
    STATUS = current
    status.publish(STATUS)

def sleepDot(time):
    for i in range(time):
        print('.')
        rospy.sleep(1.0)

def updateLocationAndSleep(time):
    x = 0
    y = 0
    loc = PoseWithCovarianceStamped()
    for i in range(time):
        loc.header.frame_id = 'map'
        loc.header.stamp = rospy.Time.now()
        loc.pose.pose.position.x = x - (time - i - 1)
        loc.pose.pose.position.y = y - (time - i - 1)
        loc.pose.pose.position.z = 0
        loc.pose.pose.orientation = Quaternion(0, 0, 0, 0)
        location.publish(loc)
        print('.')
        rospy.sleep(1.0)
    
def goal_cb(msg):
    updateStatus("moving")

if __name__ == '__main__':
    global STATUS
    STATUS = 'idle'
    rospy.init_node('feats_simulator', anonymous=True)
    rate = rospy.Rate(1.0)
    print('FEATS simulator starting...')
    print('')
    rospy.Subscriber('/route_planner/goalXYT', Vector3, goal_cb)
    print('FEATS simulator ready!')
    print('')
    while not rospy.is_shutdown():
        if STATUS == 'moving':
            updateLocationAndSleep(10)
            print('Arrived at destination! Waiting for operator input...')
            updateStatus('stopped')
            sleepDot(5)
            print('Operator has loaded / unloaded the AMR. Ready for next destination.')
            print('')
            updateStatus('ready')
        rate.sleep()