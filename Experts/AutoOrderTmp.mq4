//+------------------------------------------------------------------+
//|                                                    AutoOrderTmp.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs
extern double movieStopLoss = 300;//止损点

/**
* 突破策略，每个货币对每天下一单
* author: liangxifeng
* date: 2020-07-14
*/


//外部输入参数订单id
//extern int magic = "订单id";
//extern string note = "注释";
//判断一根K线只开一单
datetime t = 0;
extern double keyPrice = 1;//突破值
extern double stopProfit = 600;//止盈点
extern double stopLoss = 380;//止损点
extern int 大周期均线=28;
extern int 小周期均线=5;

//+------------------------------------------------------------------+
//| mt4最先执行的初始化函数                               |
//+------------------------------------------------------------------+
int OnInit()
  {
//创建一个计时器，每个5秒执行一次 OnTimer()函数
//EventSetTimer(5);
   return(INIT_SUCCEEDED);
  }
//计时器，每隔几秒执行一次
void OnTimer()
  {

  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

   return;
  }


//+------------------------------------------------------------------+
//| 价格变动一次执行该函数                                           |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
      //北京时间当前小时
      int curHour=TimeHour(TimeLocal());
      //下午2点之前，23点后不开单 
      if(curHour<15 || curHour > 23)
      {
         return;
      }
      //周一最高价
      double week1High = iHigh(NULL,PERIOD_D1,DayOfWeek()-1);
      //周一最底价
      double week1Low = iLow(NULL,PERIOD_D1,DayOfWeek()-1);
      //周一最高 - 最底价
      double week1ChaPoint =  MathFloor( (week1High-week1Low)/Point );
      
     //获取当前货币对D1时间周期1号K线的最高价，也就是说昨天的最高价
     double hightD1 = iHigh(NULL,1440,1);
     //获取当前货币对D1时间周期1号K线的最底价，也就是说昨天的最底价
     double lowD1 = iLow(NULL,1440,1);
     double curDayOpen = iOpen(NULL,1440,0); //当天日线图开盘价
     
     //昨日最高 - 最底价
     double chaPoint =  MathFloor( (hightD1-lowD1)/Point);
     stopProfit = MathFloor(chaPoint/2);
     stopLoss = MathFloor(stopProfit/2);
     movieStopLoss = stopLoss;
     yidong();
     

     double m60Open = iOpen(NULL,60,0); //当前1小时图开盘价
     double m60Close =  iClose(NULL,60,0); //当前1小时图收盘价
     
     double m60OneOpen = iOpen(NULL,60,1); //当前货币对1号K线图1小时图开盘价
     double m60OneClose =  iClose(NULL,60,1); //当前货币对1号K线1小时图收盘价
     
     double m60OneHeigh = iHigh(NULL,60,1); //当前货币对1号K线图1小时图最高价
     double m60OneLow =  iLow(NULL,60,1); //当前货币对1号K线1小时图最低价
     
     double m30Open = iOpen(NULL,30,0); //当前30分钟图开盘价
     double m30Close =  iClose(NULL,30,0); //当前30分钟图收盘价
     double m30OneHigh = iHigh(NULL,30,1); //前30分钟图最高价
     double m30OneLow = iLow(NULL,30,1); //前30分钟图最底价   
     
     double m5Open = iOpen(NULL,5,0); //当前5分钟图开盘价
     double m5Close =  iClose(NULL,5,0); //当前5分钟图收盘价
     
     double m5OneHigh = iHigh(NULL,5,1); //前5分钟图最高价
     double m5OneLow = iLow(NULL,5,1); //前5分钟图最底价  
     
     double h4Open = iOpen(NULL,240,0); //当前4小时图开盘价
     double h4Close = iClose(NULL,240,0); //当前4小时图收盘价
     
     double h4OneHigh = iHigh(NULL,240,1); //前4小时图最高价
     double h4OneLow = iLow(NULL,240,1); //前4小时图最底价     
     double newLots = 0.01; //下单手数
     
    
    // OrderSend(Symbol(),OP_BUY,0.01,Ask,3,(Ask-0.30),(Ask+0.30),"My order",16384,0,clrGreen);
     datetime hourOpenTime = iTime(NULL,PERIOD_H1,0); //1小时图0号K线的开盘时间
     datetime DayOpenTime = iTime(NULL,PERIOD_D1,0); //日线图0号K线的开盘时间
     
     double da0=iMA(NULL,PERIOD_H4,大周期均线,0,MODE_SMA,PRICE_CLOSE,0); //获取0号K线大周期均线值
     double da1=iMA(NULL,PERIOD_H4,大周期均线,0,MODE_SMA,PRICE_CLOSE,1); //获取1号K线大周期均线值
     double xiao0=iMA(NULL,PERIOD_H4,小周期均线,0,MODE_SMA,PRICE_CLOSE,0);//获取0号K线小周期均线值
     double xiao1=iMA(NULL,PERIOD_H4,小周期均线,0,MODE_SMA,PRICE_CLOSE,1);//获取1号K线小周期均线值 
     
     //1根k线只开一单
     if(t!=DayOpenTime)
     {
         int ordersTotal = OrdersTotal(); //订单总数
         ordersTotal++;
         string zhushi = Symbol()+ordersTotal;
         
         //前一小时最高价-昨天最高价 > 30
         if ( ((m60OneHeigh-hightD1)/Point) > keyPrice && Ask > curDayOpen
              //且 买价>前一小时最高价 且 当前小时图上涨  
              && ((Ask - m60OneHeigh)/Point) > keyPrice && Ask > m60Open
              // 且当前4小时图>前一个4小时图最高价 且 4小时图上涨 
              && ((Ask-h4OneHigh)/Point) > keyPrice && Ask > h4Open 
              // 且当前30分钟图>前一个30分钟图最高价 且 30分钟图上涨
              && ((Ask-m30OneHigh)/Point)> keyPrice && Ask > m30Open
              // 且当前5分钟图>前一个5分钟图最高价 且 5分钟图上涨
              && ((Ask-m5OneHigh)/Point ) > 1 && Ask > m5Open
              // 且小周期均线上穿大周期均线(金叉)
              && xiao0>da0 && xiao1<da1              
               )
         {   
             printf(TimeLocal()+"昨天最高="+hightD1+",今天开盘="+curDayOpen+",买Ask="+Ask+"########---start");
             printf(TimeLocal()+"前H1最高="+m60OneHeigh+",H1开盘="+m60Open);
             printf(TimeLocal()+"前H4最高="+h4OneHigh+",H4开盘="+h4Open);
             printf(TimeLocal()+"前M30最高="+m30OneHigh+",M30开盘="+m30Open);
             printf(TimeLocal()+"前M5最高="+m5OneHigh+",M5开盘="+m5Open+"###################---end");
             if(buy(newLots,stopLoss,stopProfit,zhushi,ordersTotal)>0)
             { 
                  //t=当前K线开盘时间
                  t=DayOpenTime;
             }
         }   

         //前一小时最底价 < 昨天最底价 且卖价<当天开盘
         if ( ((lowD1 - m60OneLow)/Point ) > keyPrice && Bid < curDayOpen
            //且 卖价<前一小时最底价 且 当前小时图下跌 
            && ((m60OneLow - Bid)/Point) > keyPrice &&  Bid < m60Open 
            //且 卖价<前4小时最底价 且 当前4小时图下跌 
            && ((h4OneLow - Bid)/Point) > keyPrice &&  Bid < h4Open 
            //且 卖价<前30分钟最底价 且 当前30分钟图下跌 
            //&& ((m30OneLow - Bid)/Point) > keyPrice &&  Bid < m30Open 
            //且 卖价<前5分钟最底价 且 当前5分钟图下跌 
            && ((m5OneLow - Bid)/Point) > 1 &&  Bid < m5Open 
            // 且小周期均线下叉大周期均线（死叉）
            && xiao0<da0 && xiao1>da1
            ) 
         {
             printf(TimeLocal()+"昨天最底="+lowD1+",今天开盘="+curDayOpen+",卖Bid="+Bid+"########---start");
             printf(TimeLocal()+"前H1最底="+m60OneLow+",H1开盘="+m60Open);
             printf(TimeLocal()+"前H4最低="+h4OneLow+",H4开盘="+h4Open);
             printf(TimeLocal()+"前M30最低="+m30OneLow+",M30开盘="+m30Open);
             printf(TimeLocal()+"前M5最低="+m5OneLow+",M5开盘="+m5Open+"###################---end");
             if (sell(newLots,stopLoss,stopProfit,zhushi,ordersTotal) > 0) 
             {
                  t=DayOpenTime;
             }
         }
     }  
  }
//+------------------------------------------------------------------+

/**
 *平仓
 * param zhushi 注释
 * param mag 订单id
 */
void close(string zhushi,int mag)
  {
   int a=OrdersTotal(); //订单总数
   for(int i=a-1; i>=0; i--)
     {
      //选中订单
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         //找到要平仓的订单
         if(OrderComment()==zhushi && OrderMagicNumber()==mag)
           {
            /**
            * 第一个参数：OrderTicket 订单编号
            * 第二个参数：平仓手数，OrderLots()/2代表平一半，OrderLots()代表全部平仓
            * 第三个参数：平仓价格（当前的卖/买价）
            * 第四个参数：滑点 50
            * 第五个参数：颜色（K线中表示）
            */
            OrderClose(OrderTicket(),OrderLots()/2,OrderClosePrice(),50,Green);
           }
        }
     }
  }
//+------------------------------------------------------------------+
/**
* 开多单
* 第一个参数 lots 下单手数
* 第二个参数 sl 止损价格 0不设止损
* 第三个参数 tp 止盈价格 0不设止盈
* 第四个参数 com 注释
* 第五个参数 buymagic 自定义订单编号（id）
* 返回值：开单成功=订单号，开单失败=-1
*/
int buy(double lots,double sl, double tp, string com, int buymagic)
  {
   printf(TimeLocal()+"开多单----");
   int a = 0;
   bool zhaodao = false; //是否找到已经存在的订单，找到就不允许重复开单了
//循环所有的单子 OrdersTotal()就是当前的订单数量
   for(int i=0; i<=OrdersTotal(); i++)
     {
      //OrderSelect()选中订单，
      //第一个参数是序号，
      //第二个参数SELECT_BY_POS是序号模式，
      //第三个参数代表选择现在的单子还是历史单子MODE_TRADES（现在的单子）
      //如果选到了单子
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) == true)
        {
         //获取选中订单的信息
         int ti = OrderTicket(); //获取订单编号(系统生成的)
         //double op = OrderOpenPrice(); //开盘价
         //double sl = OrderStopLoss() //止损价格
         //double lots = OrderLots(); //下单手数量
         string zhushi = OrderComment(); //注释
         int ma = OrderMagicNumber(); //订单号（自定义的）
         //如果当前货币对下，都是买单，注释和订单id相等情况下就代表找到了已经存在的订单
         //if(OrderSymbol() == Symbol() && OrderType() == OP_BUY &&  zhushi == com && ma == buymagic)
         if(OrderSymbol() == Symbol() && OrderType() == OP_BUY)
           {
            zhaodao = true;
            break;
           }
        }
     }
//如果没有找到就继续开单
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
   printf(TimeLocal()+"多单返回结果="+a+",zhaodao="+zhaodao);
   return(a);
  }
/**
* 开空单
* 返回值：开单成功=订单号，开单失败=-1
*/
int sell(double lots,double sl, double tp, string com, int sellmagic)
  {
   printf(TimeLocal()+"开空单----lots="+lots+",sl="+sl+",tp="+tp+",com="+com+",sellmagic="+sellmagic);
   int a = 0;
   bool zhaodao = false;
   for(int i=0; i<=OrdersTotal(); i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) == true)
        {
         string zhushi = OrderComment();
         int ma = OrderMagicNumber();
         //if(OrderSymbol() == Symbol() && OrderType() == OP_SELL && zhushi == com && ma == sellmagic)
         //一个货币对当前只有一笔空单
         if(OrderSymbol() == Symbol() && OrderType() == OP_SELL)
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
   printf(TimeLocal()+"空单返回结果="+a+",zhaodao="+zhaodao);
   return(a);
  }

//--------移动止损函数----------------------------------------------------------------------------------------------------------
void yidong()
  {
   for(int i=0; i<OrdersTotal(); i++)
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
               printf("原止损="+OrderStopLoss()+",修改为="+ NormalizeDouble((buyPrice-pointNew*movieStopLoss),digits)) ;
               if(OrderStopLoss()<(buyPrice-pointNew*movieStopLoss) || (OrderStopLoss()==0))
                 {
                  bool res = OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble((buyPrice-pointNew*movieStopLoss),digits),OrderTakeProfit(),0,Green);
                  string str = ", 货币对="+OrderSymbol()+"，注释="+OrderComment()+
                               "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(buyPrice-pointNew*movieStopLoss);
                  if(!res)
                    {
                     Print("买单移动止损修改价格失败. Error code=",GetLastError()+str);
                    }
                  else
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
                  bool res = OrderModify(OrderTicket(),OrderOpenPrice(), NormalizeDouble((sellPrice+pointNew*movieStopLoss),digits),OrderTakeProfit(),0,Green);
                  string str = ", 货币对="+OrderSymbol()+"，注释="+OrderComment()+
                               "，开盘价="+OrderOpenPrice()+"，原止损价="+OrderStopLoss()+"，修改为"+(sellPrice+pointNew*movieStopLoss);
                  if(!res)
                    {
                     Print("卖单移动止损修改价格失败. Error code=",GetLastError()+str);
                    }
                  else
                    {
                     Print("卖单移动止损修改价格成功"+str);
                    }
                 }
              }
           } //type=1
        } //找到订单
     } //for
  }


//+------------------------------------------------------------------+
