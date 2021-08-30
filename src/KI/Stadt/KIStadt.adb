pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIDatentypen;
use KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut, LeseEinheitenDatenbank, LeseEinheitenGebaut;

with EinheitSuchen, KartePositionPruefen, DiplomatischerZustand, EinheitenAllgemein;
with KIEinheitenBauen, KIGebaeudeBauen;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        GefahrStadt (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      case
        LeseStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KIDatentypen.Keine_Aufgabe =>
            null;
            
         when others =>
            return;
      end case;
      
      NeuesBauprojekt  (StadtRasseNummerExtern => StadtRasseNummerExtern,
                        EinheitBauenExtern     => KIEinheitenBauen.EinheitenBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                        GebäudeBauenExtern     => KIGebaeudeBauen.GebäudeBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                        NotfallExtern          => False);
      
   end KIStadt;
   
   
   
   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
   is begin
      
      if
        EinheitBauenExtern.ID = GlobaleKonstanten.LeerEinheitenID
        and
          GebäudeBauenExtern.ID = GlobaleDatentypen.GebäudeIDMitNullwert'First
      then
         null;
         
      elsif
        EinheitBauenExtern.ID = GlobaleKonstanten.LeerEinheitenID
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (GebäudeBauenExtern.ID) + GlobaleKonstanten.GebäudeAufschlag);
         
      elsif
        GebäudeBauenExtern.ID = GlobaleDatentypen.GebäudeIDMitNullwert'First
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen);
         end case;
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (EinheitBauenExtern.ID) + GlobaleKonstanten.EinheitAufschlag);
      
      elsif
        EinheitBauenExtern.Bewertung >= GebäudeBauenExtern.Bewertung
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen);
         end case;
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (EinheitBauenExtern.ID) + GlobaleKonstanten.EinheitAufschlag);

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => Positive (GebäudeBauenExtern.ID) + GlobaleKonstanten.GebäudeAufschlag);
      end if;
      
   end NeuesBauprojekt;
   
   
   
   function GefahrStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      FeindNahe := False;
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                             KoordinatenExtern => KartenWert);
                  if
                    FremdeEinheit.Platznummer = GlobaleKonstanten.LeerEinheitStadtNummer
                  then
                     null;
                     
                  elsif
                    DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => StadtRasseNummerExtern.Rasse,
                                                                       FremdeRasseExtern => FremdeEinheit.Rasse)
                    /= GlobaleDatentypen.Krieg
                  then
                     null;
                     
                  else
                     case
                       LeseEinheitenDatenbank.EinheitArt (RasseExtern => FremdeEinheit.Rasse,
                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => FremdeEinheit))
                     is
                        when GlobaleDatentypen.Leer | GlobaleDatentypen.Arbeiter =>
                           null;
            
                        when others =>
                           FeindNahe := True;
                           exit YAchseSchleife;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        FeindNahe
      is
         when True =>
            NotfallEinheit := GlobaleDatentypen.EinheitenIDMitNullWert'First;
            
         when False =>
            return False;
      end case;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in GlobaleDatentypen.EinheitenID'Range loop
         
         if
           LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                              IDExtern    => EinheitenSchleifenwert)
           = GlobaleDatentypen.Arbeiter
           or
             LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                IDExtern    => EinheitenSchleifenwert)
           = GlobaleDatentypen.Leer
         then
            null;
            
         elsif
           EinheitenAllgemein.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                            IDExtern               => EinheitenSchleifenwert)
           = True
         then
            NotfallEinheitBauen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 EinheitIDExtern        => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      case
        NotfallEinheit
      is
         when GlobaleDatentypen.EinheitenIDMitNullWert'First =>
            return False;
            
         when others =>
            NeuesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                             EinheitBauenExtern     => (NotfallEinheit, 1),
                             GebäudeBauenExtern     => (GlobaleDatentypen.GebäudeIDMitNullwert'First, 0),
                             NotfallExtern          => True);
            return True;
      end case;
      
   end GefahrStadt;
   
   
   
   procedure NotfallEinheitBauen
   -- Stadt mit übergeben und später die Baukosten noch mit in die Bewertung einfließen lassen.
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      EinheitIDExtern : in GlobaleDatentypen.EinheitenID)
   is begin
      
      if
        NotfallEinheit = GlobaleDatentypen.EinheitenIDMitNullWert'First
      then
         NotfallEinheit := EinheitIDExtern;
         
      elsif
        LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                        IDExtern    => NotfallEinheit)
        +
        LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => NotfallEinheit)
        < LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                          IDExtern    => EinheitIDExtern)
        +
        LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                             IDExtern    => EinheitIDExtern)
      then
         NotfallEinheit := EinheitIDExtern;
         
      else
         null;
      end if;
      
   end NotfallEinheitBauen;
     
end KIStadt;
