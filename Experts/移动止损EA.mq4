//+------------------------------------------------------------------+
//|                                                       移动止损EA.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
/**
* 移动止损EA，在一个没有订单的货币对上执行该EA;
* 会把所有其他货币对订单循环判断，设置移动止损
* author: liangxifeng 
* date: 2020-07-14
*/
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

extern double movieStopLoss = 200;//止损点
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
void OnTick()
  {
//---
      yidong();
   
  }
//+------------------------------------------------------------------+

//--------移动止损函数----------------------------------------------------------------------------------------------------------
void yidong()
  {
     for(int i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                printf("找到单子数量i="+i);
                //if(OrderType()==0 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                if(OrderType()==0) //如果是买单
                  {
                  
                    //printf("是买单,Bid="+Bid+",开盘价="+OrderOpenPrice()+",cha="+ (Bid-OrderOpenPrice()) +",移动点="+Point*movieStopLoss+
                    //       "，比较结果="+ ((Bid-OrderOpenPrice())>=Point*movieStopLoss) + "止损点="+OrderStopLoss()  );
                     if((Bid-OrderOpenPrice())>=Point*movieStopLoss)
                      {
                         if(OrderStopLoss()<(Bid-Point*movieStopLoss) || (OrderStopLoss()==0))
                           {
                              bool res = OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*200,OrderTakeProfit(),0,Green);
                              string str = ", 货币对="+OrderSymbol()+"，注释="+OrderComment()+
                                     "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(Bid-Point*movieStopLoss);
                              if(!res)
                                {
                                    Print("买单移动止损修改价格失败. Error code=",GetLastError()+str); 
                                }else 
                                {
                                     Print("买单移动止损修改价格成功"+str);
                                }
                             
                           }
                      }      
                  }
                //if(OrderType()==1 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                if(OrderType()==1)//如果是卖单
                      {
                         if((OrderStopLoss()>(Ask+Point*movieStopLoss)) || (OrderStopLoss()==0))
                           {
                              printf("卖单移动止损，货币对="+OrderSymbol()+"，注释="+OrderComment()+
                                     "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+ (Ask+Point*movieStopLoss) );
                              bool res = OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*movieStopLoss,OrderTakeProfit(),0,Green);
                              if(!res)
                                {
                                    Print("卖单移动止损修改价格失败. Error code=",GetLastError()); 
                                }else 
                                {
                                     Print("卖单移动止损修改价格成功,货币对="+OrderSymbol()+"，注释="+OrderComment()+
                                     "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(Ask+Point*movieStopLoss));
                                }
                           }
                      }
                  }
              }
   }
