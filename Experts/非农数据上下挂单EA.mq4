#property copyright "˲��Ĺ��QQ:215607364"
#property link      "http://www.zhinengjiaoyi.com"
extern datetime �ҵ����ص���ʱ��=0;
extern int �ҵ��۾��뵱ʱ�ּ۵���=200;
extern int �ҵ���Ч������=10;
extern double �ҵ��µ���=0.1;
extern int �ҵ�ֹ�����=200;
extern int �ҵ�ֹӯ����=200;
extern int �ҵ��ɽ����ƶ�ֹ�����=200;
extern int magic=405215;
datetime dangshi=0;
int sells=0;
int buys=0;
int init()
  {
   DrawLabel("will1","���ܽ�����www.zhinengjiaoyi.com,˲��Ĺ��QQ��215607364",2,13,"����",9,Aqua,0);
   dangshi=TimeLocal();
   return(0);
  }
int deinit()
  {
   return(0);
  }
int start()
  {
    if(�ҵ��ɽ����ƶ�ֹ�����>0)
     {
       yidong();
     }
    if(�ҵ����ص���ʱ��==0)
      {
         while(sells==0 || buys==0)
          {
             if(sellstop(�ҵ��µ���,�ҵ�ֹ�����,�ҵ�ֹӯ����,Symbol()+"sell",Bid-�ҵ��۾��뵱ʱ�ּ۵���*Point,magic,TimeLocal()+�ҵ���Ч������*60)>0)
               {
                  sells=1;
               }
             if(buystop(�ҵ��µ���,�ҵ�ֹ�����,�ҵ�ֹӯ����,Symbol()+"buy",Bid+�ҵ��۾��뵱ʱ�ּ۵���*Point,magic,TimeLocal()+�ҵ���Ч������*60)>0)
               {
                  buys=1;
               }
              Sleep(1000);
          }
      }
    else
      {
        if(�ҵ����ص���ʱ��<=dangshi)
          {
            Alert("����ҵ�ʱ���Ѿ����˻���ô�ҵ�");
          }
        else
          {
             if(�ҵ����ص���ʱ��<=TimeLocal())
               {
                 while(sells==0 || buys==0)
                  {
                     if(sellstop(�ҵ��µ���,�ҵ�ֹ�����,�ҵ�ֹӯ����,Symbol()+"sell",Bid-�ҵ��۾��뵱ʱ�ּ۵���*Point,magic,TimeLocal()+�ҵ���Ч������*60)>0)
                       {
                          sells=1;
                       }
                     if(buystop(�ҵ��µ���,�ҵ�ֹ�����,�ҵ�ֹӯ����,Symbol()+"buy",Bid+�ҵ��۾��뵱ʱ�ּ۵���*Point,magic,TimeLocal()+�ҵ���Ч������*60)>0)
                       {
                          buys=1;
                       }
                      Sleep(1000);
                  }
               }
          }
      }
   return(0);
  }
void yidong()
  {
    for(int i=0;i<OrdersTotal();i++)//�ƶ�ֹ��ͨ�ô���,�δ�����Զ����buy��sell���������ƶ�ֹ��
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                if(OrderType()==0 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                  {
                     if((Bid-OrderOpenPrice()) >=Point*�ҵ��ɽ����ƶ�ֹ�����)
                      {
                         if(OrderStopLoss()<(Bid-Point*�ҵ��ɽ����ƶ�ֹ�����) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*�ҵ��ɽ����ƶ�ֹ�����,0,0,Green);
                           }
                      }      
                  }
                if(OrderType()==1 && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
                  {
                    if((OrderOpenPrice()-Ask)>=(Point*�ҵ��ɽ����ƶ�ֹ�����))
                      {
                         if((OrderStopLoss()>(Ask+Point*�ҵ��ɽ����ƶ�ֹ�����)) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*�ҵ��ɽ����ƶ�ֹ�����,0,0,Red);
                           }
                      }
                  }
               }
         }
  }
void DrawLabel(string name,string text,int X,int Y,string FontName,int FontSize,color FontColor,int zhongxin)
{
   if(ObjectFind(name)!=0)
   {
    ObjectDelete(name);
    ObjectCreate(name,OBJ_LABEL,0,0,0);
      ObjectSet(name,OBJPROP_CORNER,zhongxin);
      ObjectSet(name,OBJPROP_XDISTANCE,X);
      ObjectSet(name,OBJPROP_YDISTANCE,Y);
    }  
   ObjectSetText(name,text,FontSize,FontName,FontColor);
   WindowRedraw();
}
int buystop(double Lots,double sun,double ying,string comment,double price,int magic,datetime shijian)
  {
    int kaidanok=0;
    int kaiguan=0;
    int ticket=0;
      for(int i=0;i<OrdersTotal();i++)
         {
             if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
               {
                 if((OrderComment()==comment) && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)  
                   {
                     kaiguan=1;                     
                   } 
                }
         }
      if(kaiguan==0)
        {
          if((sun!=0)&&(ying!=0))
            {
              ticket=OrderSend(Symbol( ) ,OP_BUYSTOP,Lots,price,0,price-sun*Point,price+ying*Point,comment,magic,shijian,White);
            }
          if((sun==0)&&(ying!=0))
            {
              ticket=OrderSend(Symbol( ) ,OP_BUYSTOP,Lots,price,0,0,price+ying*Point,comment,magic,shijian,White);
            }
           if((sun!=0)&&(ying==0))
            {
              ticket=OrderSend(Symbol( ) ,OP_BUYSTOP,Lots,price,0,price-sun*Point,0,comment,magic,shijian,White);
            }
           if((sun==0)&&(ying==0))
            {
              ticket=OrderSend(Symbol( ) ,OP_BUYSTOP,Lots,price,0,0,0,comment,magic,shijian,White);
            }
            kaidanok=ticket;
        }
      return(kaidanok);  
  }
int sellstop(double Lots,double sun,double ying,string comment,double price,int magic,datetime shijian)
    {
    int kaidanok=0;
    int kaiguan=0;
    int ticket=0;
      for(int i=0;i<OrdersTotal();i++)
         {
             if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
               {
                 if((OrderComment()==comment) && OrderSymbol()==Symbol() && OrderMagicNumber()==magic)    
                   {
                     kaiguan=1;                     
                   } 
                }
         }
      if(kaiguan==0)
        {
           if((sun!=0)&&(ying!=0))
             {
                ticket=OrderSend(Symbol( ) ,OP_SELLSTOP,Lots,price,0,price+sun*Point,price-ying*Point,comment,magic,shijian,Red);
             }
           if((sun==0)&&(ying!=0))
             {
                ticket=OrderSend(Symbol( ) ,OP_SELLSTOP,Lots,price,0,0,price-ying*Point,comment,magic,shijian,Red);
             }
           if((sun!=0)&&(ying==0))
             {
                ticket=OrderSend(Symbol( ) ,OP_SELLSTOP,Lots,price,0,price+sun*Point,0,comment,magic,shijian,Red);
             }
           if((sun==0)&&(ying==0))
             {
                ticket=OrderSend(Symbol( ) ,OP_SELLSTOP,Lots,price,0,0,0,comment,magic,shijian,Red);
             }
           kaidanok=ticket;
        }
      return(kaidanok);  
   }