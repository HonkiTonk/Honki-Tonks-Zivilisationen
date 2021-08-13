pragma SPARK_Mode (On);

with GebaeudeDatenbank, VerbesserungenDatenbank, KartenDatenbank;

with KartenAllgemein;

package body KampfwerteStadtErmitteln is

   function AktuelleVerteidigungStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := VerbesserungenDatenbank.VerbesserungListe (GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse,
                                                                     StadtRasseNummerExtern.Platznummer).ID).VerbesserungWerte (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Verteidigung) 
        + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                    RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.FlussVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                             RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.WegVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                           RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.RessourceVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                 RasseExtern    => StadtRasseNummerExtern.Rasse);
              
      if
        KartenAllgemein.FeldGrund (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position) /= GlobaleDatentypen.Hügel
        and
          KartenAllgemein.FeldHügel (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position) = True
      then
         VerteidigungWert := VerteidigungWert
           + KartenAllgemein.GrundVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                RasseExtern    => StadtRasseNummerExtern.Rasse)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Verteidigung) / 2;
                 
      else
         VerteidigungWert := VerteidigungWert
           + KartenAllgemein.GrundVerteidigung (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                RasseExtern    => StadtRasseNummerExtern.Rasse);
      end if;
      
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
        + KartenAllgemein.FlussAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                        RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.WegAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                      RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.VerbesserungAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                               RasseExtern    => StadtRasseNummerExtern.Rasse)
        + KartenAllgemein.RessourceAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                            RasseExtern    => StadtRasseNummerExtern.Rasse);
              
      if
        KartenAllgemein.FeldGrund (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position) /= GlobaleDatentypen.Hügel
        and
          KartenAllgemein.FeldHügel (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position) = True
      then
         AngriffWert := AngriffWert
           + KartenAllgemein.GrundAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                           RasseExtern    => StadtRasseNummerExtern.Rasse)
           + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.Angriff) / 2;
                 
      else
         AngriffWert := AngriffWert
           + KartenAllgemein.GrundAngriff (PositionExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                           RasseExtern    => StadtRasseNummerExtern.Rasse);
      end if;
      
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
      
      -- Noch einen Angriffsbonus einbauen? Aber wenn auf welche Basis?
      
      return AngriffWert;
      
   end AktuellerAngriffStadt;

end KampfwerteStadtErmitteln;
