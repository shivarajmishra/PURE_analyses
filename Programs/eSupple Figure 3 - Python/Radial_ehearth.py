
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

plt.figure(figsize=(3.841, 7.195), dpi=100)

# Ensures reproducibility of random numbers
# rng = np.random.default_rng(123)
# # Build a dataset
# df = pd.DataFrame({
#     "name": [f"item {i}" for i in range(1, 51)],
#     "value": rng.integers(low=30, high=100, size=50),
#     "group": ["A"] * 10 + ["B"] * 20 + ["C"] * 12 + ["D"] * 8
# })

import pandas as pd

data = [
    ["India", 17.3, "LIC"],
    ["China", 34.0, "LMIC"],
    ["South Africa", 51.1, "UMIC"],
    ["Colombia", 10.6, "LMIC"],
    ["UAE", 2.25, "HIC"],
    ["Zimbabwe", 24.1, "LIC"],
    ["Brazil", 18.0, "UMIC"],
    ["Sweden", 27.5, "HIC"],
    ["Chile", 58.1, "UMIC"],
    ["Iran", 6.07, "LMIC"],
    ["Canada", 52.1, "HIC"],
    ["Argentina", 15.5, "UMIC"],
    ["Poland", 34.8, "UMIC"],
    ["Malaysia", 8.45, "UMIC"],
    ["Bangladesh", 11.3, "LIC"],
    ["Turkey", 5.64, "UMIC"],
    ["Pakistan", 14.9, "LIC"],
    ["Tanzania", 27.4, "LIC"],
    ["Saudi Arabia", 4.10, "HIC"],
    ["Philippines", 17.4, "LMIC"],
    ["Russia", 13.7, "UMIC"],
]

# Create a DataFrame
df = pd.DataFrame(data, columns=["name", "value", "group"])

# Define the desired order of income groups
group_order = ["LIC", "LMIC", "UMIC", "HIC"]

# Sort the DataFrame based on the specified order
df['group'] = pd.Categorical(df['group'], categories=group_order, ordered=True)
df = df.sort_values(by='group')

# Reset the index
df.reset_index(drop=True, inplace=True)

# Print the final dataset df
print(df)

def get_label_rotation(angle, offset):
    # Rotation must be specified in degrees :(
    rotation = np.rad2deg(angle + offset)
    if angle <= np.pi:
        alignment = "right"
        rotation = rotation + 180
    else: 
        alignment = "right"
        rotation = rotation + 180
    return rotation, alignment

def add_labels(angles, values, labels, offset, ax):
    
    # This is the space between the end of the bar and the label
    padding = 2
    
    # Iterate over angles, values, and labels, to add all of them.
    for angle, value, label, in zip(angles, values, labels):
        angle = angle
        
        # Obtain text rotation and alignment
        rotation, alignment = get_label_rotation(angle, offset)

        # And finally add the text
        ax.text(
            x=angle, 
            y=value + padding, 
            s=label, 
            ha=alignment, 
            va="center", 
            rotation=rotation, 
            rotation_mode="anchor",fontsize=18, color='#6d756f'
        ) 

# def addlabels(x,y):
#     for i in range(len(df["name"])):
#         plt.text(i, df["value"][i], y[i], ha = 'center',va='top', fontsize=15)

# All this part is like the code above
VALUES = df["value"].values
LABELS = df["name"].astype(str) + "("+ df["value"].astype(str) + "%" +")"
GROUP = df["group"].values

PAD = 1
ANGLES_N = len(VALUES) + PAD * len(np.unique(GROUP))
ANGLES = np.linspace(0, 2 * np.pi, num=ANGLES_N, endpoint=False)
WIDTH = (2 * np.pi) / len(ANGLES)

GROUPS_SIZE = [len(i[1]) for i in df.groupby("group")]

offset = 0
IDXS = []
for size in GROUPS_SIZE:
    IDXS += list(range(offset + PAD, offset + size + PAD))
    offset += size + PAD

fig, ax = plt.subplots(figsize=(20, 10), subplot_kw={"projection": "polar"})
ax.set_theta_offset(offset)
ax.set_ylim(-100, 100)
ax.set_frame_on(False)
ax.xaxis.grid(False)
ax.yaxis.grid(False)
ax.set_xticks([])
ax.set_yticks([])
fig

GROUPS_SIZE = [len(i[1]) for i in df.groupby("group")]
COLORS = [f"C{i}" for i, size in enumerate(GROUPS_SIZE) for _ in range(size)]

ax.bar(
    ANGLES[IDXS], VALUES, width=WIDTH, color=COLORS, 
    edgecolor="white", linewidth=2
)

add_labels(ANGLES[IDXS], VALUES, LABELS, offset, ax)

# addlabels(df["name"], df["value"])
# Extra customization below here --------------------

# This iterates over the sizes of the groups adding reference
# lines and annotations.

offset = 0 
for group, size in zip(["LIC", "LMIC", "UMIC", "HIC"], GROUPS_SIZE):
    # Add line below bars
    x1 = np.linspace(ANGLES[offset + PAD], ANGLES[offset + size + PAD - 1], num=50)
    ax.plot(x1, [-5] * 50, color="#333333")
    
    # Add text to indicate group
    ax.text(
        np.mean(x1), -20, group, color="#333333", fontsize=14, 
        fontweight="bold", ha="center", va="center"
    )
    
    # Add reference lines at 20, 40, 60, and 80
    x2 = np.linspace(ANGLES[offset], ANGLES[offset + PAD - 1], num=50)
    ax.plot(x2, [20] * 50, color="#bebebe", lw=0.8)
    ax.plot(x2, [40] * 50, color="#bebebe", lw=0.8)
    ax.plot(x2, [60] * 50, color="#bebebe", lw=0.8)
    ax.plot(x2, [80] * 50, color="#bebebe", lw=0.8)
    
    offset += size + PAD
fig.show()
fig.savefig('Radial_ehearth.png', dpi=300,bbox_inches='tight')