import matplotlib.pyplot as plt

chrs = {}

with open('diversity_level.windowed.pi', 'r') as f:
    info = f.readlines()

pi_dict = {}
for i in range(2, len(info)):#skip the first line
    line = info[i].split("\t")
    pi_dict[int(line[1])] = float(line[4]) 
print(pi_dict)

data = [list(), list()]
for i in range(1, 30000-500, 500):
    data[0].append(i)
    if i in pi_dict:
        data[1].append(pi_dict[i])
    else:
        data[1].append(0.0)
    print(i, data[0][-1], data[1][-1])

plt.plot(data[0], data[1])
plt.xlabel('SARS-CoV-2 de novo assembly (nucleotide position)')
plt.ylabel('pi')
plt.grid(True)


plt.show()
