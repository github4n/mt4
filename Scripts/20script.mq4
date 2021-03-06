#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
#property show_inputs //拖入货币对窗口是提示输入参数
//zigzag三个参数
input int InpDepth=12;     // Depth
input int InpDeviation=5;  // Deviation
input int InpBackstep=3;   // Backstep
//定义zigzag数组, 总计可以存放12个高低点价格 (波浪理论存6个高点和6个底点)
double zigzag[12];
/**
* ZigZag指标调用 (获取指定K线数量范围中的波峰(高点)和波谷(低点)的价格)
*/
void OnStart()
  {
    int jishu=0;
    //在10000根K线中找10个高低点,查找的顺序为从右向左
    for(int i=0;i<10000;i++) 
     {
       if(zigzagzhi(i)>0) //第i根k线存在高/低点
        {
          if(jishu>11)
           {
             break;
           }
          zigzag[jishu]=zigzagzhi(i);
          jishu++;
        }
     }
    if(zigzag[0]>zigzag[1])
     {
       Alert("第一个点是高点:"+zigzag[0]);
     }
    else
     {
       Alert("第一个点是低点"+zigzag[0]);
     }
  }
//获取zigzag指标数据,如果对应shift K线不是高低点位置，则返回0
double zigzagzhi(int shift)
  {
    //ZigZag=指标名称
    //InpDepth,InpDeviation,InpBackstep,0 指的是参数
    //shift为K线序列
    return(iCustom(NULL,0,"ZigZag",InpDepth,InpDeviation,InpBackstep,0,shift));
  }
