//+------------------------------------------------------------------+
//|                                                      9script.mq4 |
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
      /*
      if(AccountNumber() != 123456) 
      {
         Alert("账户号码不对");
         return;
      }*/
      //查找字符串 llo w 返回找到的位置index=2
      printf("find res = "+ StringFind("hello world","llo w",0));
      
      if(StringFind(AccountCompany(),"IronFx",0) >=0 )
      {
         Alert("交易商不同！");
      }
      if(IsDemo() == true) printf("当前登陆的是模拟账户");
      printf("当前登陆的账户号码："+ AccountNumber());
      printf("当前登陆的账户名字："+ AccountName()); 
      printf("交易商名字："+ AccountCompany());
      printf("账户余额："+ AccountBalance());
      printf("净值："+ AccountEquity());//如果由单子在运行，该值实时变动
      printf("已用保证金："+ AccountMargin());
      Print("账户可用保证金 = ",AccountFreeMargin());
      Print("账户#",AccountNumber(), " 杠杆比率", AccountLeverage());
      Print("账户总利润", AccountProfit());
      
      //获取货币对函数MarketInfo,比如：一天当中欧元兑美元最底价
      Print("EURUSD日最底价=",MarketInfo("EURUSD",MODE_LOW));
      Print("EURUSD最后价格跳动时间戳秒=",MarketInfo("EURUSD",MODE_TIME));
      //年.月.日 时：分：秒
      Print("EURUSD最后价格跳动时间=",TimeToStr(MarketInfo("EURUSD",MODE_TIME),TIME_DATE|TIME_SECONDS));
      //0.00001
      Print("EURUSD一个点价格=",DoubleToStr(MarketInfo("EURUSD",MODE_POINT),8)); //8代表小数点后8位数      //0.00001
      //5
      Print("EURUSD小数位数=",MarketInfo("EURUSD",MODE_DIGITS));
      //14,点差也等于买价-卖价
      Print("EURUSD点差=",MarketInfo("EURUSD",MODE_SPREAD));
      //10
      Print("EURUSD止损离市价至少个点=",MarketInfo("EURUSD",MODE_STOPLEVEL));
      //100000(10万美元) 
      Print("EURUSD一标准手代表的金额=",MarketInfo("EURUSD",MODE_LOTSIZE));
     //下一标准手的单子，当价格波动一个点的时候，盈利或者亏损的值，这里EURUSD等于1美元
      Print("EURUSD一手波动一点的盈亏金额=",MarketInfo("EURUSD",MODE_TICKVALUE));
      

  }
//+------------------------------------------------------------------+
