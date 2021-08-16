pragma SPARK_Mode (On);

with GebaeudeDatenbank, VerbesserungenDatenbank;

with GesamtwerteFeld;

package body KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := VerbesserungenDatenbank.VerbesserungListe (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                                     StadtRasseNummerExtern.Platznummer).ID).VerbesserungWerte (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Verteidigung)
        + GesamtwerteFeld.FeldVerteidigung (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                            RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = False
         then
            null;
            
         else
            VerteidigungWert := VerteidigungWert + GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).VerteidigungBonus;
         end if;
         
      end loop GebäudeSchleife;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungStadt;
   
   
   
   function AktuellerAngriffStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWert := VerbesserungenDatenbank.VerbesserungListe (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                                StadtRasseNummerExtern.Platznummer).ID).VerbesserungWerte (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Angriff)
        + GesamtwerteFeld.FeldAngriff (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                       RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GebäudeSchleifenwert) = False
         then
            null;
            
         else
            AngriffWert := AngriffWert + GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GebäudeSchleifenwert).AngriffBonus;
         end if;
         
      end loop GebäudeSchleife;
      
      -- Noch einen Angriffsbonus einbauen? Aber wenn auf welcher Basis?
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmitteln;
