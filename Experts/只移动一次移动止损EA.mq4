//+------------------------------------------------------------------+
//|                                           ֻ�ƶ�һ���ƶ�ֹ��.mq4 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
extern int �ƶ�ֹ�����=200;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
   yidong();
   return(0);
  }
void yidong()
  {
     for(int i=0;i<OrdersTotal();i++)//�ƶ�ֹ��ͨ�ô���,�δ�����Զ����buy��sell���������ƶ�ֹ��
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                if(OrderType()==0 && OrderSymbol()==Symbol())
                  {
                     if((Bid-OrderOpenPrice()) >=Point*�ƶ�ֹ�����)
                      {
                         if(NormalizeDouble(OrderStopLoss(),Digits)!=NormalizeDouble(Bid-Point*�ƶ�ֹ�����,Digits))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*�ƶ�ֹ�����,OrderTakeProfit(),0,Green);
                           }
                      }      
                  }
                if(OrderType()==1 && OrderSymbol()==Symbol())
                  {
                    if((OrderOpenPrice()-Ask)>=(Point*�ƶ�ֹ�����))
                      {
                         if(NormalizeDouble(OrderStopLoss(),Digits)!=NormalizeDouble(Ask+Point*�ƶ�ֹ�����,Digits))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*�ƶ�ֹ�����,OrderTakeProfit(),0,Red);
                           }
                      }
                  }
              }
         }
   }