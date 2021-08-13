pragma SPARK_Mode (On);

with GlobaleKonstanten;

with EinheitenDatenbank, KartenDatenbank;

with KartenAllgemein, StadtSuchen;

package body KampfwerteEinheitErmitteln is

   -- Mit_Hügel noch berücksichtigen
   function AktuelleVerteidigungEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      VerteidigungWert := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Verteidigung;
      
      case
        AngreiferExtern
      is
         when False =>
            VerteidigungWert := VerteidigungWert
              + KartenAllgemein.FlussVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                   RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.WegVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                 RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.VerbesserungVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                          RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.RessourceVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                       RasseExtern    => EinheitRasseNummerExtern.Rasse);
              
            if
              KartenAllgemein.FeldGrund (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position) /= GlobaleDatentypen.Hügel
              and
                KartenAllgemein.FeldHügel (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position) = True
            then
               VerteidigungWert := VerteidigungWert
                 + KartenAllgemein.GrundVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                      RasseExtern    => EinheitRasseNummerExtern.Rasse)
                 + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (EinheitRasseNummerExtern.Rasse, GlobaleDatentypen.Verteidigung) / 2;
                 
            else
               VerteidigungWert := VerteidigungWert
                 + KartenAllgemein.GrundVerteidigung (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                      RasseExtern    => EinheitRasseNummerExtern.Rasse);
            end if;
            
            case
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung
            is
               when GlobaleDatentypen.Verschanzen =>
                  if
                    Float (VerteidigungWert) * VerschanzungBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * VerschanzungBonus);
                  end if;
                  
               when others =>
                  null;
            end case;
            
            case
              StadtSuchen.KoordinatenStadtMitRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                          KoordinatenExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position)
            is
               when GlobaleKonstanten.LeerEinheitStadtNummer =>
                  null;
                  
               when others =>
                  if
                    Float (VerteidigungWert) * StadtBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
                  then
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld'Last;
                     
                  else              
                     VerteidigungWert := GlobaleDatentypen.ProduktionFeld (Float (VerteidigungWert) * StadtBonus);
                  end if;
            end case;
              
         when True =>
            null;
      end case;
      
      return VerteidigungWert;
      
   end AktuelleVerteidigungEinheit;
   
   
   
   function AktuellerAngriffEinheit
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AngreiferExtern : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      AngriffWert := EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).ID).Angriff;
      
      case
        AngreiferExtern
      is
         when True =>
            AngriffWert := AngriffWert
              + KartenAllgemein.FlussAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                              RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.WegAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                            RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.VerbesserungAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                     RasseExtern    => EinheitRasseNummerExtern.Rasse)
              + KartenAllgemein.RessourceAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                  RasseExtern    => EinheitRasseNummerExtern.Rasse);
              
            if
              KartenAllgemein.FeldGrund (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position) /= GlobaleDatentypen.Hügel
              and
                KartenAllgemein.FeldHügel (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position) = True
            then
               AngriffWert := AngriffWert
                 + KartenAllgemein.GrundAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                 RasseExtern    => EinheitRasseNummerExtern.Rasse)
                 + KartenDatenbank.KartenListe (GlobaleDatentypen.Hügel_Mit).FeldWerte (EinheitRasseNummerExtern.Rasse, GlobaleDatentypen.Angriff) / 2;
                 
            else
               AngriffWert := AngriffWert
                 + KartenAllgemein.GrundAngriff (PositionExtern => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                                 RasseExtern    => EinheitRasseNummerExtern.Rasse);
            end if;
            
            -- Diesen Bonus anders gestalten, vielleicht auf Basis der Bewegungspunkte?
            if
              Float (AngriffWert) * AngriffBonus > Float (GlobaleDatentypen.ProduktionFeld'Last)
            then
               AngriffWert := GlobaleDatentypen.ProduktionFeld'Last;
                 
            else              
               AngriffWert := GlobaleDatentypen.ProduktionFeld (Float (AngriffWert) * AngriffBonus);
            end if;
            
         when False =>
            null;
      end case;
     
      return AngriffWert;
   
   end AktuellerAngriffEinheit;

end KampfwerteEinheitErmitteln;
