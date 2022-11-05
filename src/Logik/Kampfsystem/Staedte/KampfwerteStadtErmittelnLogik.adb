pragma Warnings (Off, "*array aggregate*");

with KampfDatentypen; use KampfDatentypen;
with StadtDatentypen;
with KartenKonstanten;

with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;

with KartenfelderwerteLogik;

package body KampfwerteStadtErmittelnLogik is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      VerteidigungWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                         RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                         WelcherWertExtern  => KartenKonstanten.KampfVerteidigung)
        + KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
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
      return KampfDatentypen.KampfwerteGroß
   is begin
      
      AngriffWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                    RasseExtern        => StadtRasseNummerExtern.Rasse,
                                                                    WelcherWertExtern  => KartenKonstanten.KampfAngriff)
        + KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
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
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
