pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with Weltkarte;

with KartengeneratorVariablenLogik;

package body ZufallsgeneratorenKartenLogik is
   
   function KartengeneratorZufallswerte
     return KartenDatentypen.Auswahlbereich
   is begin
      
      ZufälligeZahl.Reset (Gen => ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (Gen => ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorBoolean
     return Boolean
   is begin
      
      ZufälligerBoolean.Reset (Gen => ZufälligerBooleanGewählt);
      return ZufälligerBoolean.Random (Gen => ZufälligerBooleanGewählt);
      
   end KartengeneratorBoolean;
   
   
   
   function KartengeneratorLandgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MinimalerWert := KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse;
            MaximalerWert := KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse;
            
            if
              MinimalerWert > Weltkarte.Karteneinstellungen.Kartengröße.YAchse
            then
               MinimalerWert := Weltkarte.Karteneinstellungen.Kartengröße.YAchse;
               
            else
               null;
            end if;
            
            if
              MaximalerWert > Weltkarte.Karteneinstellungen.Kartengröße.YAchse
            then
               MaximalerWert := Weltkarte.Karteneinstellungen.Kartengröße.YAchse;
               
            else
               null;
            end if;

         when False =>
            MinimalerWert := KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse;
            MaximalerWert := KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse;
            
            if
              MinimalerWert > Weltkarte.Karteneinstellungen.Kartengröße.XAchse
            then
               MinimalerWert := Weltkarte.Karteneinstellungen.Kartengröße.XAchse;
               
            else
               null;
            end if;
            
            if
              MaximalerWert > Weltkarte.Karteneinstellungen.Kartengröße.XAchse
            then
               MaximalerWert := Weltkarte.Karteneinstellungen.Kartengröße.XAchse;
               
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
