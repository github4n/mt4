//+------------------------------------------------------------------+
//|                                                      5script.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
      //当前买价
      double a = Ask;
      //当前卖价
      double b = Bid;
      //获取英镑兑美元的买价
      double c = MarketInfo("GBPUSD",MODE_ASK);
      //获取英镑兑美元的卖价
      double d = MarketInfo("GBPUSD",MODE_BID);
      double op = Open[0];
      double hp = High[0];
      double lp = Low[0];
      double cp = Close[0];
      //获取15分钟图0号序列K线图的开盘价
      double op15m = iOpen(NULL,15,0);
      //获取英镑兑美元1分钟图的第3号K线图的最高价
      double hight1m = iHigh("GBPUSD",1,3);
      printf(hight1m);
      //从0号序列开始获取前10个K线中最高价的那根K线序号
      int highbar = iHighest(NULL,0,MODE_HIGH,10,0);
      //从0号序列开始获取前10个K线中最低价的那根K线序号
      int lowbar = iLowest(NULL,0,MODE_LOW,10,0);
   
  }
//+------------------------------------------------------------------+
