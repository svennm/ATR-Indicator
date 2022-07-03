//+------------------------------------------------------------------+
//|                                                  ATR Channel.mq5 |
//|                                           Copyright 2022, Svenn1 |
//|                                                   youdidthis.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Svenn1"
#property link      "youdidthis.com"
#property version   "1.00"
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

//indicator properties
#property indicator_buffers 3;
#property indicator_plots 3;

//main line properties
#property indicator_color1 clrAliceBlue
#property indicator_label1 "Main"
#property indicator_style1 STYLE_SOLID
#property indicator_type1 DRAW_LINE
#property indicator_width1 2

//upper line properties
#property indicator_color2 clrBlack
#property indicator_label2 "Upper Band"
#property indicator_style2 STYLE_DOT
#property indicator_type2 DRAW_LINE
#property indicator_width2 1

//lower line properties
#property indicator_color3 clrYellow
#property indicator_label3 "Lower Band"
#property indicator_style3 STYLE_DOT
#property indicator_type3 DRAW_LINE
#property indicator_width3 1

//inputs of the indicator

//Moving average
input int inpMABars = 14;// Moving average bars
input ENUM_MA_METHOD inpMAMethod = MODE_SMA; // Moving average Method
input ENUM_APPLIED_PRICE inpMAAppliedPrice = PRICE_CLOSE;


// ATR
input int inpATRBars = 14;
input double  inpATRFactor = 3.0;

//indicator data buffer

double BufferMain[];
double BufferUpper[];
double BufferLower[];

// internal indicator handles

int HandleMA;
int HandleATR;
double ValuesMA[];
double ValuesATR[];

// Initialisation

int OnInit() {

   SetIndexBuffer(BASE_LINE, BufferMain);
   SetIndexBuffer(UPPER_BAND, BufferUpper);
   SetIndexBuffer(LOWER_BAND, BufferLower);
   
   ArraySetAsSeries(BufferMain, true);
   ArraySetAsSeries(BufferUpper, true);
   ArraySetAsSeries(BufferLower, true);
   
   HandleMA = iMA(Symbol(), Period(), inpMABars, 0, inpMAMethod, inpMAAppliedPrice);
   HandleATR = iATR(Symbol(), Period(), inpATRBars);
   
   ArraySetAsSeries(ValuesMA, true);
   ArraySetAsSeries(ValuesATR, true);
   
   if(HandleMA == INVALID_HANDLE || HandleATR == INVALID_HANDLE) {
      Print("Failed to work");
      return(INIT_FAILED);
      }
   
   return (INIT_SUCCEEDED);
   }
   
   
   void OnDeinit(const int reason) {
   IndicatorRelease(HandleATR);
   IndicatorRelease(HandleMA);
   }
   
   int OnCalculate(
   const int rates_total,
   const int prev_calculated,
   const datetime &time[],
   const double &open[],
   const double &high[],
   const double &low[],
   const double &close[],
   const long &tick_volume[],
   const long &volume[],
   const int &spread[]
   ) {
   // how many bars to calculate
   int count = rates_total - prev_calculated;
   if(prev_calculated>0) count++;
   
   CopyBuffer(HandleMA, 0, 0, count, ValuesMA);
   CopyBuffer(HandleATR, 0, 0, count, ValuesATR);
   
   
   // count down = left to right
   for(int i = count - 1; i >=0; i--) {
      BufferMain[i] = ValuesMA[i];
      double channelWidth = inpATRFactor * ValuesATR[i];
      BufferUpper[i] = BufferMain[i] + channelWidth;
      BufferLower[i] = BufferMain[i] - channelWidth;
      }
   return(rates_total);
   }
   
   
   
   

   
   
   
   















//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
