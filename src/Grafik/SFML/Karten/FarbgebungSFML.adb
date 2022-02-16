pragma SPARK_Mode (On);

with Fehler;

package body FarbgebungSFML is

   function FarbeKartenfeldErmitteln
     (GrundExtern : in KartenDatentypen.Karten_Grund_Vorhanden_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Unterwasser_Eis =>
            return (255, 245, 238, 255);
            
         when KartenDatentypen.Wasser | KartenDatentypen.Unterwasser_Wasser =>
            return (0, 0, 205, 255);
            
         when KartenDatentypen.Flachland =>
            return (100, 160, 60, 255);
            
         when KartenDatentypen.Tundra =>
            return (205, 200, 177, 255);
            
         when KartenDatentypen.Wüste | KartenDatentypen.Sand =>
            return (238, 238, 0, 255);
            
         when KartenDatentypen.Hügel =>
            return (205, 133, 63, 255);
            
         when KartenDatentypen.Gebirge =>
            return (120, 120, 120, 255);
            
         when KartenDatentypen.Wald =>
            return (30, 130, 30, 255);
            
         when KartenDatentypen.Dschungel =>
            return (0, 70, 0, 255);
            
         when KartenDatentypen.Küstengewässer | KartenDatentypen.Unterwasser_Küstengewässer =>
            return (135, 206, 250, 255);
            
         when KartenDatentypen.Sumpf =>
            return (0, 40, 0, 255);

         when KartenDatentypen.Erde =>
            return (139, 69, 19, 255);
            
         when KartenDatentypen.Erdgestein =>
            return (120, 120, 120, 255);
            
         when KartenDatentypen.Lava =>
            return (250, 39, 39, 255);
            
         when KartenDatentypen.Wolken =>
            return (236, 236, 236, 255);
            
         when KartenDatentypen.Weltraum =>
            return (127, 127, 127, 255);
            
         when KartenDatentypen.Gestein =>
            return (87, 87, 87, 255);   
            
         when KartenDatentypen.Planetenkern =>
            return (205, 0, 0, 255);
            
         when KartenDatentypen.Unterwasser_Wald =>
            return (127, 255, 212, 255);
            
         when KartenDatentypen.Korallen =>
            return (255, 114, 86, 255);
                        
         when others =>
            Fehler.GrafikStopp (FehlermeldungExtern => "KarteSFML.FarbeErmitteln - Keine gültige Farbe gefunden.");
            -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
            return (0, 0, 0, 0);
      end case;
      
   end FarbeKartenfeldErmitteln;
   
   
   
   function FarbeFlussErmitteln
     (FlussExtern : in KartenDatentypen.Karten_Fluss_Enum)
      return Sf.Graphics.Color.sfColor
   is begin
      
      case
        FlussExtern
      is
         when KartenDatentypen.Karten_Grund_Fluss_Enum'Range =>
            null;
            
         when KartenDatentypen.Karten_Grund_Unterirdischer_Fluss_Enum'Range =>
            null;
            
         when KartenDatentypen.Karten_Grund_Lavafluss_Enum'Range =>
            null;
      end case;
      
      return (0, 0, 0, 0);
            
   end FarbeFlussErmitteln;
   
   
   
   -- -------------------
   -- function FarbeVerbesserungErmitteln ???
   -- function FarbeEinheitErmitteln ???

end FarbgebungSFML;
