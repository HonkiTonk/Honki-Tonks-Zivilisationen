with ZufallegeneratorenAllgemein;

package body KIAchsenzufallLogik is

   function AlleAchsen
     return KartenRecords.AchsenKartenfeldRecord
   is
      use type KartenDatentypen.Ebene;
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            AlleAchsenZufall.EAchse := 1;
            
         when False =>
            AlleAchsenZufall.EAchse := -1;
      end case;
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            AlleAchsenZufall.YAchse := 1;
            
         when False =>
            AlleAchsenZufall.YAchse := -1;
      end case;
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            AlleAchsenZufall.XAchse := 1;
            
         when False =>
            AlleAchsenZufall.XAchse := -1;
      end case;
      
      return AlleAchsenZufall;
      
   end AlleAchsen;
   
   
   
   function YXAchsen
     return KartenRecords.YXAchsenKartenfeldRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            YXAchsenZufall.YAchse := 1;
            
         when False =>
            YXAchsenZufall.YAchse := -1;
      end case;
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            YXAchsenZufall.XAchse := 1;
            
         when False =>
            YXAchsenZufall.XAchse := -1;
      end case;
      
      return YXAchsenZufall;
      
   end YXAchsen;
   
   
   
   function EinzelneAchse
     return KartenDatentypen.Kartenfeld
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            return 1;
            
         when False =>
            return -1;
      end case;
      
   end EinzelneAchse;
   
   
   
   function EbenenAchse
     return KartenDatentypen.EbenenbereichEins
   is
      use type KartenDatentypen.Ebene;
   begin
      
      case
        ZufallegeneratorenAllgemein.Münzwurf
      is
         when True =>
            return 1;
            
         when False =>
            return -1;
      end case;
      
   end EbenenAchse;

end KIAchsenzufallLogik;
