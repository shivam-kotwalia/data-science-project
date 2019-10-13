import streamlit as st
import numpy as np 
import pandas as pd
import time
import datetime

st.title("My first App")

name = st.text_input('Enter your name', 'Shivam Kotwalia')
st.write('Welcome ', name)

d = st.date_input(
    "When's your birthday", 
    datetime.date(2019, 7, 6))
st.write('Your birthday is:', d)

t = st.time_input('Set an alarm for', datetime.time(8, 45))
st.write('Alarm is set for', t)

with st.spinner('Wait for it...'):
    time.sleep(5)
st.success('Done!')

st.write("---------------------------")
st.write("Showing the sample data")
df = pd.DataFrame({
    "Product" : ["A", "B", "C", "D"],
    "Sales"   : [14, 13, 14, 17]
})

st.write(df)
st.write("---------------------------")
st.write("Another way of show casing dataframe")
st.table(df)




chart_data = pd.DataFrame(
     np.random.randn(20, 3),
     columns=['A', 'B', 'C'])
st.write("Showing in tabular format")
st.dataframe(chart_data, 1000, 1000)

st.line_chart(chart_data)


if st.checkbox('Show Map'):
    map_data = pd.DataFrame(
        np.random.randn(1000, 2) / [50, 50] + [37.76, -122.4],
        columns=['lat', 'lon'])
    st.code("np.random.randn(1000, 2) / [50, 50] + [37.76, -122.4]")
    st.dataframe(map_data)
    st.map(map_data)



option = st.selectbox(
    'Which number do you like best?',
     df['Product'])

'You selected: ', option



option2 = st.sidebar.selectbox(
    'Which number do you like best?',
     df['Product'])

'You selected:', option2


'Starting a long computation...'

# Add a placeholder
latest_iteration = st.empty()
bar = st.progress(0)

for i in range(10):  
  # Update the progress bar with each iteration.
  latest_iteration.text(f'Iteration {i+1}')
  # Remember progress take int values till 100 and float values till 1.0
  bar.progress(i+1)
  time.sleep(0.1)

'...and now we\'re done!'



st.write("***********************************************************")
DATE_COLUMN = 'date/time'
DATA_URL = ('https://s3-us-west-2.amazonaws.com/'
         'streamlit-demo-data/uber-raw-data-sep14.csv.gz')

@st.cache
def load_data(nrows):
    data = pd.read_csv(DATA_URL, nrows=nrows)
    lowercase = lambda x: str(x).lower()
    data.rename(lowercase, axis='columns', inplace=True)
    data[DATE_COLUMN] = pd.to_datetime(data[DATE_COLUMN])
    return data

# Create a text element and let the reader know the data is loading.
data_load_state = st.text('Loading data...')
# Load 10,000 rows of data into the dataframe.
data = load_data(10000)
# Notify the reader that the data was successfully loaded.
data_load_state.text('Loading data...done!')


st.dataframe(data.sample(20))

st.subheader('Number of pickups by hour')
hist_values = np.histogram(
    data[DATE_COLUMN].dt.hour, bins=24, range=(0,24))[0]
st.bar_chart(hist_values)


hour_to_filter = st.slider('hour', 0, 23, 17)

hour_to_filter = 17
filtered_data = data[data[DATE_COLUMN].dt.hour == hour_to_filter]
st.subheader(f'Map of all pickups at {hour_to_filter}:00')
st.map(filtered_data)


dataframe = pd.DataFrame(
    np.random.randn(10, 20),
    columns=('col %d' % i for i in range(20)))

st.dataframe(dataframe.style.highlight_max(axis=0))




progress_bar = st.progress(0)
status_text = st.empty()
chart = st.line_chart(np.random.randn(10, 2))

for i in range(100):
    # Update progress bar.
    progress_bar.progress(i)

    new_rows = np.random.randn(10, 2)

    # Update status text.
    status_text.text(
        'The latest random number is: %s' % new_rows[-1, 1])

    # Append data to the chart.
    chart.add_rows(new_rows)

    # Pretend we're doing some computation that takes time.
    time.sleep(0.1)

status_text.text('Done!')




with st.echo():
    print("This will render the code as well as execute!")
    print(2+2)


st.balloons()