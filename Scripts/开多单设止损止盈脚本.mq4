//+------------------------------------------------------------------+
//|                                         ���൥��ֹ��ֹӯ�ű�.mq4 |
//|                                           ˲��Ĺ��QQ:215607364 |
//|                                     http://www.zhinengjiaoyi.com |
//+------------------------------------------------------------------+
#property copyright "˲��Ĺ��QQ:215607364"
#property link      "http://www.zhinengjiaoyi.com"
extern double �µ�����=0.1;
extern int ֹ�����=200;
extern int ֹӯ����=200;
int magic=0;
string comment="";
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
   DrawLabel("will1","���ܽ�����www.zhinengjiaoyi.com,˲��Ĺ��QQ��215607364",5,15,"����",11,Aqua,0);
   buy(�µ�����,ֹ�����,ֹӯ����);
   return(0);
  }
int buy(double Lots,double sun,double ying)
  {
                   int ticket=OrderSend(Symbol( ) ,OP_BUY,Lots,Ask,500,0,0,comment,magic,0,White);
                   Sleep(500);
                   if(ticket>0)
                   {
                    if(OrderSelect(ticket, SELECT_BY_TICKET)==true)
                      {
                       if((sun!=0)&&(ying!=0))
                        {
                           OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-sun*MarketInfo(Symbol(),MODE_POINT),OrderOpenPrice()+ying*MarketInfo(Symbol(),MODE_POINT),0,Red);
                        }
                       if((sun==0)&&(ying!=0))
                        {
                          OrderModify(OrderTicket(),OrderOpenPrice(),0,OrderOpenPrice()+ying*MarketInfo(Symbol(),MODE_POINT),0,Red);
                        }
                       if((sun!=0)&&(ying==0))
                        {
                          OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-sun*MarketInfo(Symbol(),MODE_POINT),0,0,Red);
                        }
                      }
                   }
              return(ticket);
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