//+------------------------------------------------------------------+
//|                                                          3EA.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#define KEY_NUMPAD_5       12 
#define KEY_LEFT           37 
#define KEY_UP             38 
#define KEY_RIGHT          39 
#define KEY_DOWN           40 
#define KEY_NUMLOCK_DOWN   98 
#define KEY_NUMLOCK_LEFT  100 
#define KEY_NUMLOCK_5     101 
#define KEY_NUMLOCK_RIGHT 102 
#define KEY_NUMLOCK_UP    104
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
//初始化的时候运行一次
int OnInit()
  {
//--- create timer
   //创建一个计时器，每个5秒执行一次 OnTimer()函数
   EventSetTimer(5);
   //--- enable object create events 
   ChartSetInteger(ChartID(),CHART_EVENT_OBJECT_CREATE,true); 
//--- enable object delete events 
   ChartSetInteger(ChartID(),CHART_EVENT_OBJECT_DELETE,true); 
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
//切换时间周期，或关闭图表，或修改EA的参数的时候会触发该函数
void OnDeinit(const int reason)
  {
   Print(__FUNCTION__,"_Uninitalization reason code = ",reason); 
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| 价格变动一次执行一次该函数                                            |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
//计时器，每隔几秒执行一次
void OnTimer()
  {
//---打印当前时间
  // Print(TimeLocal());
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
//通过id捕获动作类型，鼠标点击，键盘点击等等
//通过后面三个参数捕获具体动作，后面三个参数作用相同，不同的是变量类型不同
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   if(id == CHARTEVENT_KEYDOWN)
   {
      if(lparam == 'J' || lparam == 'j')
      {
         printf("按下了键盘J键");
      }
   }
      
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+ 
//| get text description                                             | 
//+------------------------------------------------------------------+ 
string getUninitReasonText(int reasonCode) 
  { 
   string text=""; 
//--- 
   switch(reasonCode) 
     { 
      case REASON_ACCOUNT: 
         text="Account was changed";break; 
      case REASON_CHARTCHANGE: 
         text="Symbol or timeframe was changed";break; 
      case REASON_CHARTCLOSE: 
         text="Chart was closed";break; 
      case REASON_PARAMETERS: 
         text="Input-parameter was changed";break; 
      case REASON_RECOMPILE: 
         text="Program "+__FILE__+" was recompiled";break; 
      case REASON_REMOVE: 
         text="Program "+__FILE__+" was removed from chart";break; 
      case REASON_TEMPLATE: 
         text="New template was applied to chart";break; 
      default:text="Another reason"; 
     } 
//--- 
   return text; 
  } 
