pragma SPARK_Mode (Off);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Fehler;
with KartengeneratorVariablen;

package body ZufallsgeneratorenKarten is
   
   function KartengeneratorZufallswerte
     return KartenDatentypen.Auswahlbereich
   is begin
      
      ZufälligeZahl.Reset (ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorBoolean
     return Boolean
   is begin
      
      ZufälligerBoolean.Reset (ZufälligerBooleanGewählt);
      return ZufälligerBoolean.Random (ZufälligerBooleanGewählt);
      
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
         Fehler.LogikFehler (FehlermeldungExtern => "ZufallsgeneratorenKarten.KartengeneratorLandgrößen - Minimum größe als Maximum");

      else
         ZufälligeLandgrößenAbstände.Reset (ZufälligeLandgrößeAbstandGewählt);
      end if;

      LandgrößeSchleife:
      loop

         GezogenerWert := ZufälligeLandgrößenAbstände.Random (ZufälligeLandgrößeAbstandGewählt);

         if
           GezogenerWert in MinimalerWert .. MaximalerWert
         then
            return GezogenerWert;

         else
            null;
         end if;

      end loop LandgrößeSchleife;
      
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
         Fehler.LogikFehler (FehlermeldungExtern => "ZufallsgeneratorenKarten.KartengeneratorAbstände - Minimum größe als Maximum");

      else
         ZufälligeLandgrößenAbstände.Reset (ZufälligeLandgrößeAbstandGewählt);
      end if;

      LandabstandSchleife:
      loop

         GezogenerWert := ZufälligeLandgrößenAbstände.Random (ZufälligeLandgrößeAbstandGewählt);

         if
           GezogenerWert in MinimalerWert .. MaximalerWert
         then
            return GezogenerWert;

         else
            null;
         end if;

      end loop LandabstandSchleife;
      
   end KartengeneratorAbstände;

end ZufallsgeneratorenKarten;
