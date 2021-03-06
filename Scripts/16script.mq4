#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
/**
* 整个K线图表的操作函数练习
**/
void OnStart()
  {
    //加载模板，0=当前货币对窗口，Layers为模板名称
    //ChartApplyTemplate(0,"Layers");
    /*
    //保存模板
    if(ChartSaveTemplate(0,"hao1.tpl")==false)
      {
        //如果没有保存成功，则打印error   
        printf(GetLastError());
      }
    */
   
    //设置当前货币对图标各种属性
    //ChartSetInteger(0,CHART_COLOR_BACKGROUND,clrBlack); //修改背景颜色
    //设置价格波动一下，屏幕跟随滚动到最新K线位置
    //ChartSetInteger(0,CHART_AUTOSCROLL,1);
    //ChartSetInteger(0,CHART_SHIFT,1);
    
    //将该脚本拖入图标后，自动切换到30分钟图S
    //ChartSetInteger(0,CHART_SHIFT,1);
    //ChartSetSymbolPeriod(0,Symbol(),PERIOD_M30);
    
    //设定图表固定到某一个位置
    //ChartSetInteger(0,CHART_SCALEFIX,1);     //设置固定模式
    //ChartSetDouble(0,CHART_FIXED_MIN, 80.280); //将图表在最小值=1.280的位置
    
    //左上角打印 nihao
    //ChartSetString(0,CHART_COMMENT,"nihao");
    
    //打开GBPUSD 1分钟图
    //ChartOpen("GBPUSD",1);
    //打开USDJPY 15分钟图 
    //ChartOpen("USDJPY",15);
    
    /*
    //获取第一个货币对图标charId
    long qian=ChartFirst();
    //做最大假设，假设最多打开100个货币对窗口,遍历所有货币对窗口
    for(int i=1;i<100;i++)
      {
        //设置货币对窗口的编号chartId的左上角的位置
        ChartSetString(qian,CHART_COMMENT,qian);
        //ChartClose(qian); //关闭窗口
        
        //如果货币对是EURUSD 且 15分钟图,则修改背景色
        if(ChartSymbol(qian)=="EURUSD" && ChartPeriod(qian)==15)
         {
           ChartSetInteger(qian,CHART_COLOR_BACKGROUND,clrBlack);
         }
        //获取货币对窗口的最低价格
        double min=ChartGetDouble(qian,CHART_PRICE_MIN);
        //将最低价格设置到当前窗口左上角
        ChartSetString(qian,CHART_COMMENT,DoubleToStr(min,5));
        long next=ChartNext(qian);
        qian=next;
        if(next<0) break;
      }
     //截屏货币对窗口为图片,0=当前货币窗口，图片名称.jpg, 宽=800, 高=600, ALIGN_RIGHT代表从右边开始截
     //图片保存在MQL4/files目录下  
     ChartScreenShot(0,Symbol()+".jpg",800,600,ALIGN_RIGHT);
     */
     
     /*
     //获取当前图表上的指标个数,并遍历所有指标,删除掉
     //参数第一个0=当前货币对图表，第二个0=主窗口
     int total=ChartIndicatorsTotal(0,0);
     for(int i=0;i<total;i++)
       {
         //获取指标名称
         printf(ChartIndicatorName(0,0,i));
         //删除指标
         ChartIndicatorDelete(0,0,ChartIndicatorName(0,0,i));
       }
      */
      
     /*
     //窗口数量，一个货币对图表  中可以有多个窗口
     int wtotal=WindowsTotal();
     for(int i=0;i<wtotal;i++)
       {
         //打印EA或者脚本的名字
         printf(i+"|"+WindowExpertName());
       }
     printf(wtotal);*/

  }