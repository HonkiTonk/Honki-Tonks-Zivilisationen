pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen; use KampfDatentypen;
with StadtDatentypen;
with KartenKonstanten;

with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;

with GesamtwerteFeld;

package body KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      VerteidigungWert := KampfDatentypen.Kampfwerte (LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                     RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                     WelcherWertExtern  => KartenKonstanten.KampfVerteidigung))
        + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      WelchesGebäudeExtern   => GebäudeSchleifenwert)
         then
            null;
            
         else
            VerteidigungWert := VerteidigungWert + LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                                     IDExtern         => GebäudeSchleifenwert,
                                                                                     KampfBonusExtern => KartenKonstanten.KampfVerteidigung);
         end if;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.Kampfwerte
   is begin
      
      AngriffWert := KampfDatentypen.Kampfwerte (LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                       RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                       WelcherWertExtern  => KartenKonstanten.KampfAngriff))
        + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                       RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      WelchesGebäudeExtern   => GebäudeSchleifenwert)
         then
            null;
            
         else
            AngriffWert := AngriffWert + LeseGebaeudeDatenbank.KampfBonus (RasseExtern      => StadtRasseNummerExtern.Rasse,
                                                                           IDExtern         => GebäudeSchleifenwert,
                                                                           KampfBonusExtern => KartenKonstanten.KampfAngriff);
         end if;
         
      end loop GebäudeSchleife;
      
      -- Noch einen Angriffsbonus einbauen? Aber wenn, auf welcher Basis? äöü
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmitteln;
