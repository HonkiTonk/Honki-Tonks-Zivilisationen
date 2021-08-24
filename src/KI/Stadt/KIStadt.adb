pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;
use KIDatentypen;

with EinheitSuchen, LeseStadtGebaut, KartePositionPruefen, DiplomatischerZustand, LeseEinheitenDatenbank, LeseEinheitenGebaut, KIEinheitenBauen, KIGebaeudeBauen, SchreibeStadtGebaut;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KIDatentypen.Keine_Aufgabe =>
            null;
            
         when others =>
            GefahrStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            return;
      end case;
      
      NotAus := GlobaleDatentypen.Sichtweite'First;

      BaumöglichkeitenSchleife:
      loop
         
         EinheitBauen := KIEinheitenBauen.EinheitenBauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         GebäudeBauen := KIGebaeudeBauen.GebäudeBauen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
         if
           EinheitBauen.ID = GlobaleKonstanten.LeerEinheitenID
           and
             GebäudeBauen.ID = GlobaleDatentypen.GebäudeIDMitNullwert'First
         then
            null;

         else
            exit BaumöglichkeitenSchleife;
         end if;
         
         case
           NotAus
         is
            when GlobaleDatentypen.Sichtweite'Last =>
               return;
               
            when others =>
               NotAus := NotAus + 1;
         end case;
         
      end loop BaumöglichkeitenSchleife;
      
      if
        EinheitBauen.Bewertung >= GebäudeBauen.Bewertung
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Einheit_Bauen);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (EinheitBauen.ID) + GlobaleKonstanten.EinheitAufschlag);

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (GebäudeBauen.ID) + GlobaleKonstanten.GebäudeAufschlag);
      end if;
      
   end KIStadt;
   
   
   
   procedure GefahrStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      FeindNahe := False;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern   => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                             KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern));
                  if
                    FremdeEinheit.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                  then
                     null;
                     
                  elsif
                    DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => StadtRasseNummerExtern.Rasse,
                                                                       FremdeRasseExtern => FremdeEinheit.Rasse) /= GlobaleDatentypen.Krieg
                  then
                     null;
                     
                  else
                     FeindNahe := True;
                     exit YAchseSchleife;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        FeindNahe
      is
         when True =>
            null;
            
         when False =>
            return;
      end case;
      
      case
        LeseEinheitenDatenbank.EinheitArt (RasseExtern => FremdeEinheit.Rasse,
                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => FremdeEinheit))
      is
         when GlobaleDatentypen.Arbeiter =>
            return;
            
         when others =>
            null;
      end case;
      
      return;
        
   end GefahrStadt;

end KIStadt;
