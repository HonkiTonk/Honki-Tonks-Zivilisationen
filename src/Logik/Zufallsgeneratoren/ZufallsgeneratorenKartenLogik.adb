with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body ZufallsgeneratorenKartenLogik is
   
   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert
   is begin
      
      ZufälligeZahl.Reset (Gen => ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (Gen => ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorLandgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MinimalerWert := KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse;
            MaximalerWert := KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse;
            
            if
              MinimalerWert > LeseWeltkarteneinstellungen.YAchse
            then
               MinimalerWert := LeseWeltkarteneinstellungen.YAchse;
               
            else
               null;
            end if;
            
            if
              MaximalerWert > LeseWeltkarteneinstellungen.YAchse
            then
               MaximalerWert := LeseWeltkarteneinstellungen.YAchse;
               
            else
               null;
            end if;

         when False =>
            MinimalerWert := KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse;
            MaximalerWert := KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse;
            
            if
              MinimalerWert > LeseWeltkarteneinstellungen.XAchse
            then
               MinimalerWert := LeseWeltkarteneinstellungen.XAchse;
               
            else
               null;
            end if;
            
            if
              MaximalerWert > LeseWeltkarteneinstellungen.XAchse
            then
               MaximalerWert := LeseWeltkarteneinstellungen.XAchse;
               
            else
               null;
            end if;
      end case;
        
      if
        MinimalerWert = MaximalerWert
      then
         return MinimalerWert;

      elsif
        MinimalerWert > MaximalerWert
      then
         Zwischenspeicher := MinimalerWert;
         MinimalerWert := MaximalerWert;
         MaximalerWert := Zwischenspeicher;

      else
         null;
      end if;
      
      ZufälligeLandgrößen.Reset (Gen => ZufälligeLandgrößeGewählt);
      
      return ZufälligeLandgrößen.Random (Gen   => ZufälligeLandgrößeGewählt,
                                         First => MinimalerWert,
                                         Last  => MaximalerWert);
      
   end KartengeneratorLandgrößen;

end ZufallsgeneratorenKartenLogik;
