#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
extern string huobi="USDJPY";
/**
* 一键开仓,平仓,修改订单脚本
**/
void OnStart()
  {
    //buy(0.1,200,300,Symbol()+"buy",123456);
    //OrderSend(Symbol(),OP_BUY,0.1,Ask,50,Ask-200*Point,Ask+300*Point,"",0,0,White);
    //OrderSend(Symbol(),OP_BUY,0.2,Ask,50,Ask-200*Point,Ask+300*Point,"",0,0,White);
    //closeall();
    //modify(300,300);
    //Alert(DoubleToStr(Point,5));
    closeallprofit();
  }
//修改订单的止损和止盈，slpoint止损点数，tppoint止盈点数
void modify(int slpoint,int tppoint)
  {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               double p=MarketInfo(OrderSymbol(),MODE_POINT);
               if(OrderType()==0) //多单
                 {
                   OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-slpoint*p,OrderOpenPrice()+tppoint*p,Green);
                 }
               if(OrderType()==1) //空单
                 {
                   OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+slpoint*p,OrderOpenPrice()-tppoint*p,Green);
                 }
             }
         }
  }
//平仓多单
void closeallprofit()
  {
    while(danshuprofit()>0)
     {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               //买单或买单 且 该订单已经获利>0
               if(OrderType()<=1 && OrderProfit()>0)
                 {
                   OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Green);
                 }
               else
                 {
                   //平仓挂单
                   OrderDelete(OrderTicket());
                 }
             }
         }
     }
  }
//平仓函数，关闭所有订单
void closeall()
  {
    while(danshu()>0)
     {
       int t=OrdersTotal();
       for(int i=t-1;i>=0;i--)
         {
           if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
             {
               if(OrderType()<=1) //买单或卖单
                 {
                   //删除买单或卖单
                   OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),Green);
                 }
               else 
                 {
                   //删除挂单
                   OrderDelete(OrderTicket());
                 }
             }
         }
     }
  }
//统计当前运行的所有订单
int danshu()
  {
     int a=0;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            //if(OrderType()<=1) //买单或者卖单
              {
                a++;
              }
          }
      }
    return(a);
  }
//获取获利单数量
int danshuprofit()
  {
     int a=0;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
             if(OrderProfit()>0);
              {
                a++;
              }
          }
      }
    return(a);
  }
int buy(double lots,double sl,double tp,string com,int buymagic)
  {
    int a=0;
    bool zhaodan=false;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            string zhushi=OrderComment();
            int ma=OrderMagicNumber();
            if(OrderSymbol()==Symbol() && OrderType()==OP_BUY && zhushi==com && ma==buymagic)
              {
                zhaodan=true;
                break;
              }
          }
      }
    if(zhaodan==false)
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
int sell(double lots,double sl,double tp,string com,int sellmagic)
  {
    int a=0;
    bool zhaodan=false;
     for(int i=0;i<OrdersTotal();i++)
      {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
          {
            string zhushi=OrderComment();
            int ma=OrderMagicNumber();
            if(OrderSymbol()==Symbol() && OrderType()==OP_SELL && zhushi==com && ma==sellmagic)
              {
                zhaodan=true;
                break;
              }
          }
      }
    if(zhaodan==false)
      {
        if(sl==0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,Bid-tp*Point,com,sellmagic,0,White);
         }
        if(sl!=0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,0,com,sellmagic,0,White);
         }
        if(sl==0 && tp==0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,0,0,com,sellmagic,0,White);
         }
        if(sl!=0 && tp!=0)
         {
           a=OrderSend(Symbol(),OP_SELL,lots,Bid,50,Bid+sl*Point,Bid-tp*Point,com,sellmagic,0,White);
         }
      }
    return(a);
  }

