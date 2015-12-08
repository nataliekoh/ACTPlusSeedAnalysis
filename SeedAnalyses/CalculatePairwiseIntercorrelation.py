import numpy as np
import argparse
import os
from glob import glob

parser = argparse.ArgumentParser()
parser.add_argument('--dirname', '-d', required=True, help='working directory')

dirname=parser.parse_args().dirname

os.chdir(dirname)

regions = ['PCC', 'mPFC', 'LAG', 'RAG', 'Llattemp','Rlattemp']

#load timeseries
alltimeseries=[]

for region in regions:
	timeseriesname=glob(region + '_Sphere*ts.txt')
	print timeseriesname
	timeseries=np.loadtxt(timeseriesname[0])
	alltimeseries.append(timeseries)

for regionnum in range(0,len(regions)-1):
	for comparisonnum in range(regionnum+1,len(regions)):
		r=np.corrcoef((alltimeseries[regionnum],alltimeseries[comparisonnum]))[1,0]
		z=np.arctanh(r)
		outname='corr_' + str(regions[regionnum]) + '_to_' + str(regions[comparisonnum]) 
		np.savetxt(str(outname),z.reshape(1,),fmt='%s')
