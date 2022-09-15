pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with KartengeneratorVariablen;

package body ZufallsgeneratorenKarten is
   
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
            MinimalerWert := KartengeneratorVariablen.Landgrößen.MinimaleYAchse;
            MaximalerWert := KartengeneratorVariablen.Landgrößen.MaximaleYAchse;

         when False =>
            MinimalerWert := KartengeneratorVariablen.Landgrößen.MinimaleXAchse;
            MaximalerWert := KartengeneratorVariablen.Landgrößen.MaximaleXAchse;
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

end ZufallsgeneratorenKarten;
