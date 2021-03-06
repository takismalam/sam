//+------------------------------------------------------------------+
//|                                             super-signals_v2.mq4 |
//|                Copyright © 2006, Nick Bilak, beluck[AT]gmail.com |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2006, Nick Bilak"
#property copyright "alterations by Mark Tomlinson"
#property link      "http://www.forex-tsd.com/"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Orange
#property indicator_color2 Yellow
#property indicator_color3 Magenta
#property indicator_color4 LightYellow
//input properties

extern int dist2=34;
extern int dist1=27;
extern bool Advanced_Alert=true;
extern string Advanced_Key="t-1356213586:23665";
double b1[];
double b2[];
double b3[];
double b4[];
double alertTag;

#import "AdvancedNotificationsLib.dll"
void AdvancedAlert(string key, string text, string instrument, string timeframe, string i);
#import

int init()  {
   SetIndexStyle(0,DRAW_ARROW,STYLE_SOLID,2);
   SetIndexStyle(1,DRAW_ARROW,STYLE_SOLID,2);
   SetIndexStyle(2,DRAW_ARROW,STYLE_SOLID,2);
   SetIndexStyle(3,DRAW_ARROW,STYLE_SOLID,2);
   SetIndexArrow(1,333);
   SetIndexArrow(0,334);
   SetIndexArrow(1,233);
   SetIndexArrow(0,234);
   SetIndexBuffer(0,b1);
   SetIndexBuffer(1,b2);
   SetIndexBuffer(2,b3);
   SetIndexBuffer(3,b4);
   return(0);
}
int start() {
   int counted_bars=IndicatorCounted();
   int i,limit,hhb,llb,hhb1,llb1;
   
   if (counted_bars<0) return(-1);
   if (counted_bars>0) counted_bars--;
   limit=Bars-1;
   if(counted_bars>=1) limit=Bars-counted_bars-1;
   if (limit<0) limit=0;

   for (i=limit;i>=0;i--)   {
      hhb1 = Highest(NULL,0,MODE_HIGH,dist1,i-dist1/2);
      llb1 = Lowest(NULL,0,MODE_LOW,dist1,i-dist1/2);
      hhb= Highest(NULL,0,MODE_HIGH,dist2,i-dist2/2);
      llb= Lowest(NULL,0,MODE_LOW,dist2,i-dist2/2);

      if (i==hhb){
         b1[i]=High[hhb]+10*Point;
         if(Advanced_Alert && Advanced_Key != "" && i == 1 && alertTag!=Time[0]) AdvancedAlert(Advanced_Key,"Tak Sawang Sawang Bakal SELL 20-40 Menit iki Ojo All in Lee Marai Kere",Symbol(),Period(),i);
         alertTag = Time[0];
         }
      if (i==llb){
         b2[i]=Low[llb]-10*Point;
        if(Advanced_Alert && Advanced_Key != "" && i == 1 && alertTag!=Time[0]) AdvancedAlert(Advanced_Key,"Tak Sawang Sawang Bakal BUY 20-40 Menit iki Ojo All in Lee Marai Kere",Symbol(),Period(),i);
        alertTag = Time[0];
         }
      if (i==hhb1){
         b3[i]=High[hhb1]+4*Point;
        if(Advanced_Alert && Advanced_Key != "" && i == 1 && alertTag!=Time[0]) AdvancedAlert(Advanced_Key,"SWING SELL Diluk Luur 10-20 Menit",Symbol(),Period(),i);
       alertTag = Time[0];
         }
      if (i==llb1){
         b4[i]=Low[llb1]-4*Point;
      if(Advanced_Alert && Advanced_Key != "" && i == 1 && alertTag!=Time[0]) AdvancedAlert(Advanced_Key,"SWING BUY Diluk Luur 10-20 Menit",Symbol(),Period(),i);
      alertTag = Time[0];
         }
      }       
  return(0);
}
