#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
string oclh[4];
/**
* 文件的操作
*/
void OnStart()
  {
   //FolderCreate("f",0); //在files目录新建f目录
   //FolderDelete("f",0); //..........删除.....
   //FolderClean("a",0);  //删除files/a目录下左右子目录和文件
   
   /*
   string filename;
   //文件查找，在files中查找a开头的文件，将文件名保存为filename，每次只找出一个文件，所以需要循环配合使用
   long fff=FileFindFirst("a*",filename,0);//0代表扫描的是files目录
   if(fff!=INVALID_HANDLE)
    {
      do
       {
         //FileIsExist(filename);
       }
      while(FileFindNext(fff,filename)==true);
    }*/
    /*
    //复制文件
   if(FileCopy("a//a.txt",0,"b//b.txt",0)==false)
     {
       printf(GetLastError());
     }
   //移动文件
   if(FileMove("a//a.txt",0,"b//b.txt",0)==false)
     {
       printf(GetLastError());
     }
     */
     
    //删除文件
    //FileDelete("test.csv");
    
   /*
   //判断为你教案是否存在
   if(FileIsExist("test.csv")==true)
     {
       Alert("文件存在");
     }
   else
     {
       Alert("文件不存在");
     */
   int a=125;
   //打开文件,注意：test.csv位于mt4安装目录中的files目录下
   //以逗号方式隔开写入的内容后，写入的内容会分布在各自的表格中
   //打开CSV文件类型，FILE_SHARE_READ代表多个文件可以同时读取该csv文件，FILE_SHARE_READ代表多个文件可以同时写该csv文件，
   //CP_ACP编码相关
   int h=FileOpen("test.csv",FILE_READ|FILE_WRITE|FILE_CSV|FILE_SHARE_READ,',',CP_ACP);
   //如果打开文件成功
   if(h!=INVALID_HANDLE)
    {
   
       oclh[0]=Open[0];
       oclh[1]=Close[0];
       oclh[2]=High[0];
       oclh[3]=Low[0]; 
     //写入文件内容,h为打开文件句柄，后面的参数都是写入文件的内容
     //如果没有test.csv文件，会自动创建
     //FileWrite(h,Symbol(),Open[0],Close[0],High[0],Low[0]); //写入第一行
     //FileWrite(h,Symbol(),Open[1],Close[1],High[1],Low[1]); //写入第二行
     // FileWriteDouble(h,1.321); //写入文件的时候，需要指定文件特殊的文件类型，比如：FILE_BIN
     //定期刷新
     //FileFlush(h);
     //利用数组写入文件
     // FileWriteArray(h,oclh,0,WHOLE_ARRAY);
      
      //读取文件
      string read;
      ulong ft=0;
      while(FileIsEnding(h)!=True) //没有读到最后
        {
          
          if(FileIsLineEnding(h)==True) //读到一行的末尾
           {
             printf(read);//打印一行内容
             read="";
           }
           //指定光标读取文件的开始位置索引           
          //FileSeek(h,16,SEEK_SET); 
          ft=FileTell(h);
          read=read+FileReadString(h,0);
          //读取文件一个文字后的索引位置
          ft=FileTell(h); 
        }
        
      FileClose(h);
      
    }
  }
