with KartenRecords;
with KartenDatentypen;

package KIAchsenzufallLogik is
   pragma Elaborate_Body;

   function AlleAchsen
     return KartenRecords.AchsenKartenfeldRecord;
   
   function YXAchsen
     return KartenRecords.YXAchsenKartenfeldRecord;
   
   function EinzelneAchse
     return KartenDatentypen.Kartenfeld;
   
   function EbenenAchse
     return KartenDatentypen.EbenenbereichEins;
   
private
   
   YXAchsenZufall : KartenRecords.YXAchsenKartenfeldRecord;
   
   AlleAchsenZufall : KartenRecords.AchsenKartenfeldRecord;

end KIAchsenzufallLogik;
