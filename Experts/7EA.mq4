//+------------------------------------------------------------------+
//|                                                          7EA.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
extern int magic = 123;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() //每个价格波动，就执行一次
  {
//---
   printf("================hello=============");
   //if(Close[0] < Open[0])
   {
      //Symbol代表拖到的当前货币对名称
      //buy(0.1,100, 100,Symbol()+"duo",magic);
      //sell(0.1,100, 100,Symbol()+"kong",magic);
      if(1==1)
      {
         close("EURUSDduo",magic);
      }
   }
      //开单函数，Symbol()托到哪个货币对，就是哪个货币对名,OP_BUY开一个买单,开0.1手,Ask代表买价,10代表滑10个点
      //OrderSend(Symbol(),OP_BUY,lots,Ask,50,Ask-sl*Point,0,com,buymagic,0,White);
     // OrderSend(Symbol(),OP_BUY,0.1,Ask,10,Ask-100*Point, Ask+100*Point,"duo",123456,0,White);
   
  }
  /**
  *平仓
  */
  void close(string zhushi,int mag)
  {
    int a=OrdersTotal();
    for(int i=a-1;i>=0;i--)
      {
        //选中订单
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
         {
           if(OrderComment()==zhushi && OrderMagicNumber()==mag)
             {
               OrderClose(OrderTicket(),OrderLots()/2,OrderClosePrice(),50,Green);
             }
         }
      }
  }
//+------------------------------------------------------------------+
/**
开多单
*/
int buy(double lots,double sl, double tp, string com, int buymagic) 
{
   int a = 0;
   bool zhaodao = false;
   for( int i=0; i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) == true) 
      {
         string zhushi = OrderComment();
         int ma = OrderMagicNumber();
         if(OrderSymbol() == Symbol() && OrderType() == OP_BUY &&  zhushi == com && ma == buymagic)
         {
            zhaodao = true;
            break;
         }
      }
   }
    if(zhaodao==false)
      {
        if(sl!=0 && tp==0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,Ask-sl*Point,0,com,buymagic,0,White);
         }
        if(sl==0 && tp!=0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,0,Ask+tp*Point,com,buymagic,0,White);
         }
        if(sl==0 && tp==0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,0,0,com,buymagic,0,White);
         }
        if(sl!=0 && tp!=0)
         {
          a=OrderSend(Symbol(),OP_BUY,lots,Ask,50,Ask-sl*Point,Ask+tp*Point,com,buymagic,0,White);
         } 
      }
   return(a);
}
/**
* 开空单
*/
int sell(double lots,double sl, double tp, string com, int sellmagic) 
{
   int a = 0;
   bool zhaodao = false;
   for( int i=0; i<OrdersTotal();i++)
   {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) == true) 
      {
         string zhushi = OrderComment();
         int ma = OrderMagicNumber();
         if(OrderSymbol() == Symbol() && OrderType() == OP_SELL && zhushi == com && ma == sellmagic)
         {
            zhaodao = true;
            break;
         }
      }
   }
    if(zhaodao==false)
      {
        if(sl==0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,Bid-tp*Point,com,sellmagic,0,Red);
         }
        if(sl!=0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,0,com,sellmagic,0,Red);
         }
        if(sl==0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,0,com,sellmagic,0,Red);
         }
        if(sl!=0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,Bid-tp*Point,com,sellmagic,0,Red);
         }
      }
   return(a);
}
