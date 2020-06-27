//+------------------------------------------------------------------+
//|                                                 3indicator-2.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 1
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "Label1"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrYellow
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- indicator buffers
double         Label1Buffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Label1Buffer);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
//指标特有的函数
//rates_total=当前总的K线数量
//prev_calculated=计算过的K线
//time[0] 最新第1根k线的时间
//open[0] 最新第1根k线的开盘价
//high[0] 最新第1根k线的最高价
//low[0]  ..............最低价
//close[0]  ............收盘价
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   Print(rates_total);
   int i,limit;
   limit = rates_total - prev_calculated;
   if(prev_calculated > 0) limit++;
   for(i>=0;i<limit; i++)
   {
      Label1Buffer[i] = open[i];
   }
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+---------------------------------------------------;---------------+
