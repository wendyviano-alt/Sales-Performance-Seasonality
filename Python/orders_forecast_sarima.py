import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from statsmodels.tsa.statespace.sarimax import SARIMAX



df = dataset.copy()

df = df.rename(columns={
    'Forecast Month Key': 'month_key',
    'Total Orders': 'orders'
})

df['month_key'] = pd.to_numeric(df['month_key'], errors='coerce')
df['orders'] = pd.to_numeric(df['orders'], errors='coerce')

df = df.dropna(subset=['month_key', 'orders'])
df['month_key'] = df['month_key'].astype(int)

df['month_start'] = pd.to_datetime(
    df['month_key'].astype(str) + '01',
    format='%Y%m%d'
)

monthly_orders = (
    df
    .groupby('month_start', as_index=False)['orders']
    .sum()
    .sort_values('month_start')
)

monthly_orders = monthly_orders.set_index('month_start')
monthly_orders = monthly_orders.asfreq('MS')
monthly_orders['orders'] = monthly_orders['orders'].interpolate()



model = SARIMAX(
    monthly_orders['orders'],
    order=(1, 1, 1),
    seasonal_order=(1, 1, 1, 12),
    enforce_stationarity=False,
    enforce_invertibility=False
)

results = model.fit(disp=False)

forecast_steps = 12
forecast = results.get_forecast(steps=forecast_steps)
forecast_values = forecast.predicted_mean

forecast_df = pd.DataFrame({
    'month': forecast_values.index,
    'forecast_orders': forecast_values.values
})

forecast_df['month_label'] = forecast_df['month'].dt.strftime('%b %Y')



plt.figure(figsize=(12, 5))

bars = plt.bar(
    forecast_df['month_label'],
    forecast_df['forecast_orders'],
    label='Forecast Orders',
    color='#1E1B7A'
)

# Add markers on top of bars
plt.plot(
    forecast_df['month_label'],
    forecast_df['forecast_orders'],
    marker='o',
    linewidth=2,
    color='#D4A017',
    label='Monthly Forecast Marker'
)

# Add values outside end / above bars
for bar in bars:
    height = bar.get_height()
    plt.annotate(
        f'{height / 1000:.1f}K',
        xy=(bar.get_x() + bar.get_width() / 2, height),
        xytext=(0, 8),
        textcoords='offset points',
        ha='center',
        va='bottom',
        fontsize=9
    )

# Add room above labels
max_y = forecast_df['forecast_orders'].max()
plt.ylim(top=max_y * 1.18)

plt.title('Forecasted Orders by Month', fontsize=14, fontweight='bold')
plt.xlabel('Forecast Month')
plt.ylabel('Total Orders')

ax = plt.gca()
ax.yaxis.set_major_formatter(FuncFormatter(lambda x, pos: f'{x / 1000:.0f}K'))

plt.xticks(rotation=45)
plt.grid(axis='y', alpha=0.3)
plt.legend()
plt.tight_layout()

plt.show()
