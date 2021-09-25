pragma SPARK_Mode (On);

with GlobaleKonstanten, KartenKonstanten;

with KIDatentypen;
use KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut, LeseEinheitenDatenbank, LeseEinheitenGebaut;

with EinheitSuchen, KartePositionPruefen, DiplomatischerZustand, EinheitenModifizieren;
with KIEinheitenBauen, KIGebaeudeBauen;

package body KIStadt is

   procedure KIStadt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        FeindNahe (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            NotfallEinheit := GlobaleDatentypen.EinheitenIDMitNullWert'First;
            WelcheEinheitArt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when False =>
            return False;
      end case;
      
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
   
   
   
   function FeindNahe
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerYXKartenWert =>
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
                           return True;
                     end case;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end FeindNahe;
   
   
   
   procedure WelcheEinheitArt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
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
           EinheitenModifizieren.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               IDExtern               => EinheitenSchleifenwert)
           = True
         then
            NotfallEinheitBauen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 EinheitIDExtern        => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end WelcheEinheitArt;
   
   
   
   procedure NotfallEinheitBauen
   -- Stadt mit übergeben und später die Baukosten noch mit in die Bewertung einfließen lassen.
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
