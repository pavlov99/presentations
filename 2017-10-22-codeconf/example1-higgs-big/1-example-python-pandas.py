import time
import pandas as pd

# Read header column names from header.txt file
with open('./header.txt') as f:
    header = f.readline().split(',')

# Read CSV data with pandas. Takes ~4Gb of memory.
read_start_time = time.time()
data = pd.read_csv('./HIGGS.csv', names=header)
print("--- Read time: {} seconds ---".format(time.time() - read_start_time))

# Answer Question 1
print("Q1: Max value of lepton_eta: {}".format(data.lepton_eta.max()))

# Answer Question 2
mean_lepton_phi = dict(data.groupby(['signal']).lepton_phi.mean())
print("Q2: Average value of lepton_phi by class: 0 - {}, 1 - {}".format(
    mean_lepton_phi[0], mean_lepton_phi[1]))

# Output data
output_start_time = time.time()
data[data.m_jj > 0.75]\
    .sort_values('m_wbb')\
    .to_csv(
        '1-python-pandas.csv',
        index=False,
        columns=['signal', 'm_jj', 'm_wbb']
    )
print("--- Read time: {} seconds ---".format(time.time() - output_start_time))
