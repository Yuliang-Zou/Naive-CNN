import numpy as np
import scipy.io as sio
import caffe


def load():
	# Load the net
	caffe.set_mode_cpu()
	# You may need to train this caffemodel first
	# There should be script to help you do the training
	net = caffe.Net(root + 'lenet.prototxt', root + 'lenet_iter_10000.caffemodel',\
		caffe.TEST)
	conv1_w = net.params['conv1'][0].data
	conv1_b = net.params['conv1'][1].data
	conv2_w = net.params['conv2'][0].data
	conv2_b = net.params['conv2'][1].data
	sio.savemat('conv1_w', {'conv1_w':conv1_w})
	sio.savemat('conv1_b', {'conv1_b':conv1_b})
	sio.savemat('conv2_w', {'conv2_w':conv2_w})
	sio.savemat('conv2_b', {'conv2_b':conv2_b})

if __name__ == "__main__":
	# You will need to change this path
	root = '/Users/yuliangzou/caffe-rc3/examples/mnist/'
	load()
	print 'Caffemodel loaded and written to .mat files successfully!'