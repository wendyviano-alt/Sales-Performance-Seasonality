import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
from statsmodels.tsa.statespace.sarimax import SARIMAX



df = dataset.copy()

df = df.rename(columns={
    'Forecast Month Key': 'month_key',
    'Total Sales USD': 'sales'
})

df['month_key'] = pd.to_numeric(df['month_key'], errors='coerce')
df['sales'] = pd.to_numeric(df['sales'], errors='coerce')

df = df.dropna(subset=['month_key', 'sales'])
df['month_key'] = df['month_key'].astype(int)

# Convert YYYYMM into date
df['month_start'] = pd.to_datetime(
    df['month_key'].astype(str) + '01',
    format='%Y%m%d'
)

# Aggregate to monthly sales
monthly_sales = (
    df
    .groupby('month_start', as_index=False)['sales']
    .sum()
    .sort_values('month_start')
)

monthly_sales = monthly_sales.set_index('month_start')
monthly_sales = monthly_sales.asfreq('MS')
monthly_sales['sales'] = monthly_sales['sales'].interpolate()



model = SARIMAX(
    monthly_sales['sales'],
    order=(1, 1, 1),
    seasonal_order=(1, 1, 1, 12),
    enforce_stationarity=False,
    enforce_invertibility=False
)

results = model.fit(disp=False)

# Forecast next 12 months
forecast_steps = 12
forecast = results.get_forecast(steps=forecast_steps)
forecast_values = forecast.predicted_mean

forecast_df = pd.DataFrame({
    'month': forecast_values.index,
    'forecast_sales': forecast_values.values
})



plt.figure(figsize=(12, 5))

plt.plot(
    forecast_df['month'],
    forecast_df['forecast_sales'],
    marker='o',
    linewidth=2.5,
    label='Forecast Sales'
)

# Add value labels above the line
for x, y in zip(forecast_df['month'], forecast_df['forecast_sales']):
    plt.annotate(
        f'${y / 1_000_000:.1f}M',
        xy=(x, y),
        xytext=(0, 12),
        textcoords='offset points',
        ha='center',
        va='bottom',
        fontsize=9
    )

# Add extra space above the highest point so labels are not cut off
max_y = forecast_df['forecast_sales'].max()
plt.ylim(top=max_y * 1.15)

# Format x-axis as month name
plt.xticks(
    forecast_df['month'],
    forecast_df['month'].dt.strftime('%b %Y'),
    rotation=45
)

# Format y-axis as millions
ax = plt.gca()
ax.yaxis.set_major_formatter(FuncFormatter(lambda x, pos: f'${x / 1_000_000:.0f}M'))

plt.grid(True, alpha=0.3)
plt.tight_layout()

plt.show()
