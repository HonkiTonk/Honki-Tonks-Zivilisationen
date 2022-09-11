pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KampfDatentypen; use KampfDatentypen;
with StadtDatentypen; use StadtDatentypen;
with DiplomatieDatentypen; use DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitSuchen;
with Kartenkoordinatenberechnungssystem;
with DiplomatischerZustandLogik;
with EinheitenmodifizierungLogik;

with KIEinheitenBauen;
with KIGebaeudeBauen;

package body KIStadt is

   -- KI baut manchmal Gebäude mehrfach in einer Stadt. äöü
   procedure KIStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
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
         when KIDatentypen.Keine_Aufgabe_Enum =>
            NeuesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                             EinheitBauenExtern     => KIEinheitenBauen.EinheitenBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                             GebäudeBauenExtern     => KIGebaeudeBauen.GebäudeBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                             NotfallExtern          => False);
            
         when others =>
            return;
      end case;
      
   end KIStadt;
   
   
   
   procedure NeuesBauprojekt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
   is begin
      
      if
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
        and
          GebäudeBauenExtern.ID = StadtDatentypen.GebäudeIDMitNullwert'First
      then
         null;
         
      elsif
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (GebäudeBauenExtern.ID, 0));
         
      elsif
        GebäudeBauenExtern.ID = StadtDatentypen.GebäudeIDMitNullwert'First
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (0, EinheitBauenExtern.ID));
      
      elsif
        EinheitBauenExtern.Bewertung >= GebäudeBauenExtern.Bewertung
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                     BeschäftigungExtern   => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (0, EinheitBauenExtern.ID));

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (GebäudeBauenExtern.ID, 0));
      end if;
      
   end NeuesBauprojekt;
   
   
   
   function GefahrStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        FeindNahe (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when True =>
            NotfallEinheit := EinheitenDatentypen.EinheitenIDMitNullWert'First;
            WelcheEinheitArt (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when False =>
            return False;
      end case;
      
      case
        NotfallEinheit
      is
         when EinheitenDatentypen.EinheitenIDMitNullWert'First =>
            return False;
            
         when others =>
            NeuesBauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                             EinheitBauenExtern     => (NotfallEinheit, 1),
                             GebäudeBauenExtern     => (StadtDatentypen.GebäudeIDMitNullwert'First, 0),
                             NotfallExtern          => True);
            return True;
      end case;
      
   end GefahrStadt;
   
   
   
   function FeindNahe
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchen.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                             KoordinatenExtern => KartenWert,
                                                                                             LogikGrafikExtern => True);
                  
                  if
                    FremdeEinheit.Nummer = EinheitenKonstanten.LeerNummer
                  then
                     null;
                     
                  elsif
                    DiplomatieDatentypen.Krieg_Enum /= DiplomatischerZustandLogik.DiplomatischenStatusPrüfen (EigeneRasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                                               FremdeRasseExtern => FremdeEinheit.Rasse)
                  then
                     null;
                     
                  else
                     case
                       LeseEinheitenDatenbank.EinheitArt (RasseExtern => FremdeEinheit.Rasse,
                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => FremdeEinheit))
                     is
                        when EinheitenDatentypen.Arbeiter_Enum =>
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
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           EinheitenDatentypen.Arbeiter_Enum = LeseEinheitenDatenbank.EinheitArt (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                  IDExtern    => EinheitenSchleifenwert)
         then
            null;
            
         elsif
           True = EinheitenmodifizierungLogik.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                            IDExtern               => EinheitenSchleifenwert)
         then
            NotfallEinheitBauen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                 EinheitIDExtern        => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end WelcheEinheitArt;
   
   
   
   -- Die Baukosten noch mit in die Bewertung einfließen lassen. äöü
   procedure NotfallEinheitBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitIDExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      if
        NotfallEinheit = EinheitenDatentypen.EinheitenIDMitNullWert'First
      then
         NotfallEinheit := EinheitIDExtern;
         
      elsif
        LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                        IDExtern    => NotfallEinheit)
        + LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                               IDExtern    => NotfallEinheit)
        < LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                          IDExtern    => EinheitIDExtern)
        + LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                               IDExtern    => EinheitIDExtern)
      then
         NotfallEinheit := EinheitIDExtern;
         
      else
         null;
      end if;
      
   end NotfallEinheitBauen;
     
end KIStadt;
