//+------------------------------------------------------------------+
//|                                                      4script.mq4 |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//定义输入外部参数，将脚本拖入K线图中，会提示输入参数
//与extern或input配合使用，input在函数内部不可以修改，extern定义的变量在函数内部可以修改。
#property show_inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
//定义各种类型的全局变量
int a1 = 1;
double b = 6.8;
string c = "张三";
//光标定位在clrRed上，按F1查看更多颜色
color d=clrRed;
//光标定位在datetime上，按F1查看更多时间格式
datetime e = D'2020.01.01 00:00';

//利用枚举，自定义星期类型
enum week
{
   M=1, //星期一
   T=2, //星期二
};
//将脚本拖入K线图中，会显示key=a, value为下拉选框值为星期二，星期一的选择框
extern week a = T;
//定义数组变量
int k[10];
void OnStart()
  {
//---
   //函数内部定义的为局部变量
   //数据库存储变量的赋值和获取,类似将数据记录到数据库中，关闭编辑器启动后值依然存在
   //GlobalVariableSet("ok",10);
   double c=GlobalVariableGet("ok");
   //系统内置变量，当前买价
   double buyPrice = Ask;
   Print("当前买价="+buyPrice);
   double sellPrice = Bid;
   Print("当前卖价="+sellPrice);
   
   int a1=2;
   int b1=3;
   int res = add(a1,b1);
   printf("a1+b1="+res);
   
   //if条件语句
   if(Bid >2){
      Print("开单");
   }else {
      Print("不开单");
   }
   
   //for循环
   for(int i=0; i<10; i++) {
      k[i] = i;   
   }
   
   //while循环 平仓当前所有的单子
   while(OrdersTotal > 0) {
      //平仓
      //break, continue,retrun的用法与其他语言一致
   }
   
  }
//+------------------------------------------------------------------+
//定义函数，注意：入参&b为引用传参
int add(int a, int &b) 
{
   b=b*2;
   return a+b;
}
