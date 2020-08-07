#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| 对象的基本操作:在图标上写字,画趋势线等                                   |
//+------------------------------------------------------------------+
void OnStart()
  {
   /**
   * 创建水平线，垂直线等对象
   * 第一参数：对象名称
   * 第二个参数：对象类型，水平/垂直等等
   * 第三个参数：窗口号，0代表主窗口,1代表辅窗口，比如：MACD图形窗口
   * 第四个参数：X轴坐标，时间 Time[1] 一号K线时间 (第一个坐标)
   * 第五个参数：Y轴坐标，价格 Open[1] 1号K线开盘价(第一个坐标)
   **/
   //垂直线
   //ObjectCreate("1",OBJ_VLINE,0,Time[1],Open[1]); 
   //水平线
   ObjectCreate("2",OBJ_HLINE,0,Time[1],Open[1]);
   //获取水平线对应的价格 OBJPROP_PRICE1 注意；PRICE后面有一个1,代表1号K线
   double shuipingPrice = ObjectGet("2",OBJPROP_PRICE1);
   Alert("水平线的价格="+shuipingPrice);
   return;

   //角度线,需要两个坐标
   /*
   ObjectCreate("4",OBJ_TRENDBYANGLE,0,Time[10],Open[10],Time[0],Low[0]); 
   ObjectSet("4",OBJPROP_ANGLE,45); //角度45度
   ObjectSet("4",OBJPROP_COLOR,clrWhite); //颜色白色   
   */
   
   //斐波那契回调线,需要两个坐标
   /*
   ObjectCreate("5",OBJ_FIBO,0,Time[10],Low  [10],Time[0],High[0]); 
   ObjectSet("4",OBJPROP_ANGLE,45); //角度45度
   ObjectSet("4",OBJPROP_COLOR,clrWhite); //颜色白色 
   */
   
   
   /**
   * 修改已经画好对象的属性，比如：颜色，粗细等等
   **/
   //修改刚刚画好的水平线的颜色
   /*
   ObjectSet("2",OBJPROP_COLOR,Yellow); //修改为黄色
   ObjectSet("2",OBJPROP_WIDTH,3);      //修改水平线宽度
   */

   
   //趋势线（斜线），需要两个坐标
   ObjectCreate("3",OBJ_TREND,0,Time[10],Open[10],Time[0],Low[0]); 
   //设置趋势线为非射线,划线段，否则会无线延长为射线
   ObjectSet("3",OBJPROP_RAY,False  );
   //根据序号获取趋势线对应的,0号K线对应趋势线的价格    
   double jiage0 = ObjectGetValueByShift("3",1);
   Alert("0号K线对应趋势线的价格="+jiage0);
   
   
   
   
   
   
  }
