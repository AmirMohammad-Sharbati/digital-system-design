import matplotlib.pyplot as plt

# Data
labels = ['m_max_rise', 'm_max_fall', 'm_typ_rise', 'm_typ_fall', 'm_min_rise', 'm_min_fall',
          'ts_max_off' , 'ts_max_rise', 'ts_max_fall', 
          'ts_typ_off' , 'ts_typ_rise', 'ts_typ_fall', 
          'ts_min_off' , 'ts_min_rise', 'ts_min_fall']
values = [17, 14, 14, 11, 11, 9, 
          6, 7, 6, 5, 6, 5, 4, 5, 4]

# Create bar chart
plt.figure(figsize=(6, 4))
bars = plt.bar(labels, values, color='skyblue')

# Add values on top
for bar in bars:
    yval = bar.get_height()
    plt.text(bar.get_x() + bar.get_width()/2, yval + 0.3, str(yval), ha='center', va='bottom')

# Style
plt.title("Delay Comparison")
plt.ylabel("Delay (units)")
plt.grid(axis='y', linestyle='--', alpha=0.5)
plt.tight_layout()

# Show
plt.show()
