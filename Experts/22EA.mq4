#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
extern string 请输入试用验证码="";
int runok=0;
int OnInit()
  {
   if(IsDemo()==True)
     {
       if(请输入试用验证码=="abc")
         {
           if(TimeLocal()<D'2015.11.07 00:00')
              {
                runok=1;
                wenzi("tishi","通过验证,此验证码使用到期时间2015.11.07",15,15,10,Red);
              }
         }
       if(请输入试用验证码=="nihao")
         {
           if(TimeLocal()<D'2016.11.07 00:00')
              {
                runok=1;
                wenzi("tishi","通过验证,此验证码使用到期时间2016.11.07",15,15,10,Red);
              }
         }
     }
   if(AccountNumber()==237022)
     {
       if(TimeLocal()<D'2015.11.07 00:00')
        {
          runok=1;
          wenzi("tishi","通过验证,可以使用,使用到期时间2015.11.07",15,15,10,Red);
        }
     }
   if(AccountNumber()==523654)
     {
       if(TimeLocal()<D'2016.11.07 00:00')
        {
          runok=1;
          wenzi("tishi","通过验证,可以使用,使用到期时间2016.11.07",15,15,10,Red);
        }
     }
   if(AccountNumber()==845123)
     {
       if(TimeLocal()<D'2015.01.07 00:00')
        {
          runok=1;
          wenzi("tishi","通过验证,可以使用,使用到期时间2015.01.07",15,15,10,Red);
        }
     }
   return(INIT_SUCCEEDED);
  }
void OnDeinit(const int reason)
  {

  }
void OnTick()
  {
    if(runok==0)
     {
       wenzi("tishi","此账号没有授权,想使用可以联系QQ:123456",15,15,10,Red);
       return;
     }
    if(tradetime(10,22)==true)
     {
       //OrderSend(....);
     }
  }
bool tradetime(int starthour,int endhour)
  {
    bool a=false;
    if(starthour<=endhour)
     {
       if(TimeHour(TimeLocal())>=starthour && TimeHour(TimeLocal())<endhour)
         {
           a=true;
         }
     }
    else
     {
        if(TimeHour(TimeLocal())>=starthour || TimeHour(TimeLocal())<endhour)
         {
           a=true;
         }
     }
    return(a);
  }
void wenzi(string name,string neirong,int x,int y,int daxiao,color yanse)
  {
    if(ObjectFind(name)<0)
     {
        ObjectCreate(name,OBJ_LABEL,0,0,0);
        ObjectSetText(name,neirong,daxiao,"宋体",yanse);
        ObjectSet(name,OBJPROP_XDISTANCE,x);
        ObjectSet(name,OBJPROP_YDISTANCE,y);
        ObjectSet(name,OBJPROP_CORNER,0);
     }
    else
     {
        ObjectSetText(name,neirong,daxiao,"宋体",yanse);
        WindowRedraw();
     }
  }
