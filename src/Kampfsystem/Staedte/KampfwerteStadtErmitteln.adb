pragma SPARK_Mode (On);

with LeseStadtGebaut, LeseGebaeudeDatenbank, LeseVerbesserungenDatenbank;

with GesamtwerteFeld;

package body KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                         RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                         WelcherWertExtern  => GlobaleDatentypen.Verteidigung)
        + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                             WelchesGebäudeExtern   => GebäudeSchleifenwert) = False
         then
            null;
            
         else
            VerteidigungWert := VerteidigungWert + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                           IDExtern           => GebäudeSchleifenwert,
                                                                                           WelcherBonusExtern => GlobaleDatentypen.Verteidigung);
         end if;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWert := LeseVerbesserungenDatenbank.VerbesserungWerte (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                    RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                    WelcherWertExtern  => GlobaleDatentypen.Angriff)
        + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                       RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern   => GebäudeSchleifenwert) = False
         then
            null;
            
         else
            AngriffWert := AngriffWert + LeseGebaeudeDatenbank.PermanenterBonus (RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                                 IDExtern           => GebäudeSchleifenwert,
                                                                                 WelcherBonusExtern => GlobaleDatentypen.Angriff);
         end if;
         
      end loop GebäudeSchleife;
      
      -- Noch einen Angriffsbonus einbauen? Aber wenn, auf welcher Basis?
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmitteln;
