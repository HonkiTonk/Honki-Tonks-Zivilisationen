with StadtDatentypen;
with KartenKonstanten;

with LeseStadtGebaut;
with LeseGebaeudeDatenbank;
with LeseVerbesserungenDatenbank;

with KartenfelderwerteLogik;

package body KampfwerteStadtErmittelnLogik is

   function AktuelleVerteidigungStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      VerteidigungWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                         SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                         WelcherWertExtern  => KartenKonstanten.KampfVerteidigung)
        + KartenfelderwerteLogik.FeldVerteidigung (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                   SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      WelchesGebäudeExtern     => GebäudeSchleifenwert)
         then
            null;
            
         else
            VerteidigungWert := VerteidigungWert + LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                                     IDExtern         => GebäudeSchleifenwert,
                                                                                     KampfBonusExtern => KartenKonstanten.KampfVerteidigung);
         end if;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KampfDatentypen.KampfwerteGroß
   is
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      AngriffWert := LeseVerbesserungenDatenbank.KampfVerbesserung (VerbesserungExtern => LeseStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                                                    SpeziesExtern      => StadtSpeziesNummerExtern.Spezies,
                                                                    WelcherWertExtern  => KartenKonstanten.KampfAngriff)
        + KartenfelderwerteLogik.FeldAngriff (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                              SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                      WelchesGebäudeExtern     => GebäudeSchleifenwert)
         then
            null;
            
         else
            AngriffWert := AngriffWert + LeseGebaeudeDatenbank.KampfBonus (SpeziesExtern    => StadtSpeziesNummerExtern.Spezies,
                                                                           IDExtern         => GebäudeSchleifenwert,
                                                                           KampfBonusExtern => KartenKonstanten.KampfAngriff);
         end if;
         
      end loop GebäudeSchleife;
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmittelnLogik;
