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

extern double movieStopLoss = 300;//止损点

int OnInit()
  {
//---
    //创建一个计时器，每个2秒执行一次 OnTimer()函数
    EventSetTimer(2);
   
//---
   return(INIT_SUCCEEDED);
  }
  
void OnTimer()
{
   yidong();
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
      
   
  }
//+------------------------------------------------------------------+

//--------移动止损函数----------------------------------------------------------------------------------------------------------
void yidong()
  {
     for(int i=0;i<OrdersTotal();i++)
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                //printf("找到单子数量i="+i);
                //if(OrderType()==0 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                double pointNew = MarketInfo(OrderSymbol(),MODE_POINT);//找到的订单对应货币对点
                double digits = MarketInfo(OrderSymbol(),MODE_DIGITS);
                if(OrderType()==0) //如果是买单
                  {
                    double buyPrice = MarketInfo(OrderSymbol(),MODE_BID);//找到的订单对应货币对买价
                    
                    //printf("是买单,Bid="+buyPrice+",开盘价="+OrderOpenPrice()+",cha="+ (buyPrice-OrderOpenPrice()) +",移动点="+pointNew*movieStopLoss+
                    //       "，比较结果="+ ((buyPrice-OrderOpenPrice())>=pointNew*movieStopLoss) + "止损点="+OrderStopLoss()+",止损价将修改为"+(buyPrice-pointNew*movieStopLoss)  );
                     if((buyPrice-OrderOpenPrice())>=pointNew*movieStopLoss)
                      {
                        printf("原止损="+OrderStopLoss()+",修改为="+ NormalizeDouble( (buyPrice-pointNew*movieStopLoss),digits) ) ;
                         if(OrderStopLoss()<(buyPrice-pointNew*movieStopLoss) || (OrderStopLoss()==0))
                           {
                              bool res = OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble((buyPrice-pointNew*movieStopLoss),digits),OrderTakeProfit(),0,Green);
                              string str = ", 货币对="+OrderSymbol()+"，注释="+OrderComment()+
                                     "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(buyPrice-pointNew*movieStopLoss);
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
                     double sellPrice = MarketInfo(OrderSymbol(),MODE_ASK);//找到的订单对应货币对卖价
                     if((OrderOpenPrice()-sellPrice)>=pointNew*movieStopLoss) 
                      {
                         if((OrderStopLoss()>(sellPrice+pointNew*movieStopLoss)) || (OrderStopLoss()==0))
                           {
                              //printf("是卖单,Ask="+sellPrice+",开盘价="+OrderOpenPrice()+",cha="+ (sellPrice-OrderOpenPrice()) +",移动点="+pointNew*movieStopLoss+
                              //      "，比较结果="+ (OrderOpenPrice()-sellPrice)>=pointNew*movieStopLoss + "止损点="+OrderStopLoss()  );
                              bool res = OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble( (sellPrice+pointNew*movieStopLoss),digits),OrderTakeProfit(),0,Green);
                              string str = ", 货币对="+OrderSymbol()+"，注释="+OrderComment()+
                                     "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(sellPrice+pointNew*movieStopLoss);
                              if(!res)
                                {
                                    Print("卖单移动止损修改价格失败. Error code=",GetLastError()+str); 
                                }else 
                                {
                                     Print("卖单移动止损修改价格成功"+str);
                                }
                           }
                       }
                    } //type=1
                 } //找到订单
              } //for
   }
