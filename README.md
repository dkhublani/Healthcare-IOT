# Healthcare-IOT
HIGHLIGHT OF THIS PROJECT:- There are many wearable devices in the market which can estimate your heart rate but my goal is to PREDICT the heart ahead of time.

WHY USEFUL:-If we can predict the heart rate 5 seconds before it comes we can make devices to prevent many diseases for example device to prevent sleep apnea. So many machines can detect sleep apnea but none of them predict it before an onset of apnea episode.

MY WORK includes the following:-

* To collect data from human subjects using a SparkFun Single Lead Heart Rate Monitor 
* Collected data from 85 subjects
* Data is collected over 20 different settings for each subject
* 1600 rows corresponding to every setting
* I note down different features(race, age etc.) from every subject

* After the data is collected it is processed through a code which removes the noise and estimates  heart rate (this code cannot be shared in public due to some sensitive information)

* After getting the heart rates it is fed into Random forest model which will be used for predicting the heart  rate
* Till now I am able to achieve a maximum  R2 value of 0.78




