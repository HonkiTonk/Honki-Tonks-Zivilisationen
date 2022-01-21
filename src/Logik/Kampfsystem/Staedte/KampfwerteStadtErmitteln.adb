pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;
with KartenDatentypen;

with GesamtwerteFeld;

package body KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      VerteidigungWert := EinheitStadtDatentypen.Kampfwerte (LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                            RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                            WelcherWertExtern  => KartenDatentypen.Verteidigung))
        + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern   => GebäudeSchleifenwert)
           = False
         then
            null;
            
         else
            VerteidigungWert := VerteidigungWert + EinheitStadtDatentypen.Kampfwerte (LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                              IDExtern           => GebäudeSchleifenwert,
                                                                                                                              WelcherBonusExtern => KartenDatentypen.Verteidigung));
         end if;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Kampfwerte
   is begin
      
      AngriffWert := EinheitStadtDatentypen.Kampfwerte (LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                       RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                       WelcherWertExtern  => KartenDatentypen.Angriff))
        + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                       RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in EinheitStadtDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern   => GebäudeSchleifenwert)
           = False
         then
            null;
            
         else
            AngriffWert := AngriffWert + EinheitStadtDatentypen.Kampfwerte (LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                                                    IDExtern           => GebäudeSchleifenwert,
                                                                                                                    WelcherBonusExtern => KartenDatentypen.Angriff));
         end if;
         
      end loop GebäudeSchleife;
      
      -- Noch einen Angriffsbonus einbauen? Aber wenn, auf welcher Basis?
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmitteln;
