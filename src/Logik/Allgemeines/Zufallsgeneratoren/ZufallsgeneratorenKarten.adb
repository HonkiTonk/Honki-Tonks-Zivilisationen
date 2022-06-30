pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Fehler;
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
         Fehler.LogikFehler (FehlermeldungExtern => "ZufallsgeneratorenKarten.KartengeneratorLandgrößen - Minimum größer als Maximum");

      else
         ZufälligeLandgrößenAbstände.Reset (Gen => ZufälligeLandgrößeAbstandGewählt);
      end if;
      
      return ZufälligeLandgrößenAbstände.Random (Gen   => ZufälligeLandgrößeAbstandGewählt,
                                                     First => MinimalerWert,
                                                     Last  => MaximalerWert);
      
   end KartengeneratorLandgrößen;
   
   
   
   function KartengeneratorAbstände
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MinimalerWert := KartengeneratorVariablen.Abstände.MinimaleYAchse;
            MaximalerWert := KartengeneratorVariablen.Abstände.MaximaleYAchse;

         when False =>
            MinimalerWert := KartengeneratorVariablen.Abstände.MinimaleXAchse;
            MaximalerWert := KartengeneratorVariablen.Abstände.MaximaleXAchse;
      end case;

      if
        MinimalerWert = MaximalerWert
      then
         return MinimalerWert;

      elsif
        MinimalerWert > MaximalerWert
      then
         Fehler.LogikFehler (FehlermeldungExtern => "ZufallsgeneratorenKarten.KartengeneratorAbstände - Minimum größer als Maximum");

      else
         ZufälligeLandgrößenAbstände.Reset (Gen => ZufälligeLandgrößeAbstandGewählt);
      end if;
      
      return ZufälligeLandgrößenAbstände.Random (Gen   => ZufälligeLandgrößeAbstandGewählt,
                                                     First => MinimalerWert,
                                                     Last  => MaximalerWert);
      
   end KartengeneratorAbstände;

end ZufallsgeneratorenKarten;
