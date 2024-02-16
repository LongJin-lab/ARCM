import mindspore.numpy as np
from math import cos, sin

def b(q):
    theta1 = q[0]
    theta2 = q[1]
    theta3 = q[2]
    theta4 = q[3]
    theta5 = q[4]
    theta6 = q[5]
    theta7 = q[6]
    
    bpos = np.array([
        [(79*cos(theta1)*sin(theta2))/250 - (33*sin(theta1)*sin(theta3))/400 - (107*cos(theta6)*(sin(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)) + cos(theta1)*cos(theta4)*sin(theta2)))/1000 + (11*sin(theta6)*(sin(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)) + cos(theta1)*cos(theta4)*sin(theta2)))/125 - (11*cos(theta6)*(cos(theta5)*(cos(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)) - cos(theta1)*sin(theta2)*sin(theta4)) + sin(theta5)*(cos(theta3)*sin(theta1) + cos(theta1)*cos(theta2)*sin(theta3))))/125 + (33*cos(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)))/400 - (107*sin(theta6)*(cos(theta5)*(cos(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)) - cos(theta1)*sin(theta2)*sin(theta4)) + sin(theta5)*(cos(theta3)*sin(theta1) + cos(theta1)*cos(theta2)*sin(theta3))))/1000 + (48*sin(theta4)*(sin(theta1)*sin(theta3) - cos(theta1)*cos(theta2)*cos(theta3)))/125 - (33*cos(theta1)*sin(theta2)*sin(theta4))/400 + (33*cos(theta1)*cos(theta2)*cos(theta3))/400 + (48*cos(theta1)*cos(theta4)*sin(theta2))/125],
        [(33*cos(theta1)*sin(theta3))/400 + (79*sin(theta1)*sin(theta2))/250 + (107*cos(theta6)*(sin(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)) - cos(theta4)*sin(theta1)*sin(theta2)))/1000 - (11*sin(theta6)*(sin(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)) - cos(theta4)*sin(theta1)*sin(theta2)))/125 - (33*cos(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)))/400 + (11*cos(theta6)*(cos(theta5)*(cos(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)) + sin(theta1)*sin(theta2)*sin(theta4)) + sin(theta5)*(cos(theta1)*cos(theta3) - cos(theta2)*sin(theta1)*sin(theta3))))/125 - (48*sin(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)))/125 + (107*sin(theta6)*(cos(theta5)*(cos(theta4)*(cos(theta1)*sin(theta3) + cos(theta2)*cos(theta3)*sin(theta1)) + sin(theta1)*sin(theta2)*sin(theta4)) + sin(theta5)*(cos(theta1)*cos(theta3) - cos(theta2)*sin(theta1)*sin(theta3))))/1000 + (48*cos(theta4)*sin(theta1)*sin(theta2))/125 - (33*sin(theta1)*sin(theta2)*sin(theta4))/400 + (33*cos(theta2)*cos(theta3)*sin(theta1))/400],
        [(79*cos(theta2))/250 + (48*cos(theta2)*cos(theta4))/125 - (33*cos(theta3)*sin(theta2))/400 - (33*cos(theta2)*sin(theta4))/400 + (11*cos(theta6)*(cos(theta5)*(cos(theta2)*sin(theta4) - cos(theta3)*cos(theta4)*sin(theta2)) + sin(theta2)*sin(theta3)*sin(theta5)))/125 + (107*sin(theta6)*(cos(theta5)*(cos(theta2)*sin(theta4) - cos(theta3)*cos(theta4)*sin(theta2)) + sin(theta2)*sin(theta3)*sin(theta5)))/1000 - (107*cos(theta6)*(cos(theta2)*cos(theta4) + cos(theta3)*sin(theta2)*sin(theta4)))/1000 + (11*sin(theta6)*(cos(theta2)*cos(theta4) + cos(theta3)*sin(theta2)*sin(theta4)))/125 + (48*cos(theta3)*sin(theta2)*sin(theta4))/125 + (33*cos(theta3)*cos(theta4)*sin(theta2))/400 + 333/1000]
        ], np.float32)
    
    return bpos