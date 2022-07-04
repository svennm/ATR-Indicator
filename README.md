This is a read me for a simple ATR Channel.

The first 40 Lines of the code are me declaring the different properties for my indicator
in my case the indicator was 3 lines and so I defined their properites using the built in properites Color,Label,Style,Type,Width.


lines 41 through 56 declare the inputs and the buffers. 

The inputs are the inputs used for the indicator and can be changed in the MT5 Platform, these are MA bars for the number of bars to take into account on the MA calculation
there are then 2 inputs which are the type of Moving Average (simple, expontial, etc), and then the price to use in the Array for the moving average calculcations( We use candle sticks which are an array of 4 prices)
then 2 more inputs for the number of bars to calculate the ATR (Average true range of the candles) 

the last input declared is the ATR Chanel factor, which I assume is how wide the bands are apart from each other which kind of make the ATR,
I have it here because it was neccesary to make to code run but to those familar who know exactly what this does please let me know!

The buffers are how data is passed in and we have dynamic arrays for all 3 bands of the indicator
Lines 56 through 64 have some values and arrrays used to handle the value of MA and ATR and 2 arrays to hold the values

Lines 66 through 90 are the OnInit Function, which is called when the indicator is first placed on the chart
the SetIndex lets you assign specific line to specific buffer values (from what I am told, behind the scenes these are assigned by index (starting at 0) so the function makes it easier
The next function ArraySetAsSeries sets the values in the buffer arrays to have the current bar on the chart TF indexed to 0 (this does make it so that when you change TF on the chart you need to rerun the indicator)

Here the Handle variables are called and the iMa (MA method for calc) and iATR(ATR calculation method) are both called and to calculate the neccesary values
Symbol and Period refer to the current asset on chart and the TF that it is on. Then variable inputs that the builtin Method Uses

the values of the MA and ATR are also set as a series (because we have to make a line)
and if statement to check if the indicator has taken in the data properly and the values returned from the iMA and ATR functions have been handled properly

Lines 91 - 130 complete the code

the OnDeinit is run when the indicator is removed from the chart.
I am not sure why it takes the reason parameter and it is also not declared anywhere else in the code but does not cause a compilation error
The OnCalculate function is called whenever there is changed in the chart such as a tick movement or a canlde closure it work like and OnEvent function
rates_total is the total number of bars available in that TF (has an effect on lower time frames)
prev_calculated is something I also do not understand super well, I am aware that prev_calculated is the previous value calculated and is compared to 0. and infact is 0 on the first calculcation.
The number of bars that need to be calculated are the # of bars - bars already calculated
The if statment is for a new calculation of the indicator if the previous bar 0 is no longer 0.

CopyBuffer takes values form the handle and puts them into an array. The 0s are the buffer and where you want to begin in the array, the array will have count values
The last for loop counts down bars, count is the number of bars to calc and calc - 1 is the index value of that bar. The width is the ATR factor * ATR vaues
the upper line is spread by the channel width
and the lower line is spread by the channel with


