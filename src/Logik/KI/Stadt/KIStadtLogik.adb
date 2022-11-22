with KartenDatentypen;
with KampfDatentypen;
with StadtDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with LeseDiplomatie;

with EinheitSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with EinheitenmodifizierungLogik;

with KIDatentypen;

with KIEinheitenBauenLogik;
with KIGebaeudeBauenLogik;

package body KIStadtLogik is

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
                             EinheitBauenExtern     => KIEinheitenBauenLogik.EinheitenBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
                             GebäudeBauenExtern     => KIGebaeudeBauenLogik.GebäudeBauen (StadtRasseNummerExtern => StadtRasseNummerExtern),
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
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type KIDatentypen.BauenBewertung;
   begin
      
      if
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
        and
          GebäudeBauenExtern.ID = StadtKonstanten.LeerGebäudeID
      then
         null;
         
      elsif
        EinheitBauenExtern.ID = EinheitenKonstanten.LeerID
      then
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (GebäudeBauenExtern.ID, EinheitenKonstanten.LeerID));
         
      elsif
        GebäudeBauenExtern.ID = StadtKonstanten.LeerGebäudeID
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
                                         BauprojektExtern       => (StadtKonstanten.LeerGebäudeID, EinheitBauenExtern.ID));
      
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
                                         BauprojektExtern       => (StadtKonstanten.LeerGebäudeID, EinheitBauenExtern.ID));

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                               BeschäftigungExtern   => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         BauprojektExtern       => (GebäudeBauenExtern.ID, EinheitenKonstanten.LeerID));
      end if;
      
   end NeuesBauprojekt;
   
   
   
   function GefahrStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      case
        FeindNahe (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when False =>
            return False;
            
         when True =>
            NotfallEinheit := WelcheEinheitArt (StadtRasseNummerExtern => StadtRasseNummerExtern);
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
   is
      use type KartenDatentypen.Kartenfeld;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
         XAchseSchleife:
         for XAchseSchleifenwert in -LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) .. LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                                  KoordinatenExtern => KartenWert,
                                                                                                  LogikGrafikExtern => True);
                  
                  if
                    FremdeEinheit.Nummer = EinheitenKonstanten.LeerNummer
                  then
                     null;
                     
                  elsif
                    DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (RasseEinsExtern => StadtRasseNummerExtern.Rasse,
                                                                                        RasseZweiExtern => FremdeEinheit.Rasse)
                  then
                     null;
                     
                  else
                     case
                       LeseEinheitenDatenbank.Einheitenart (RasseExtern => FremdeEinheit.Rasse,
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
   
   
   
   function WelcheEinheitArt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is
      use type EinheitenDatentypen.Einheitart_Enum;
   begin
      
      AktuelleEinheit := EinheitenKonstanten.LeerID;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           EinheitenDatentypen.Arbeiter_Enum = LeseEinheitenDatenbank.Einheitenart (RasseExtern => StadtRasseNummerExtern.Rasse,
                                                                                    IDExtern    => EinheitenSchleifenwert)
         then
            null;
            
         elsif
           True = EinheitenmodifizierungLogik.EinheitAnforderungenErfüllt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                            IDExtern               => EinheitenSchleifenwert)
         then
            AktuelleEinheit := NotfalleinheitBauen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    AktuelleEinheitExtern  => AktuelleEinheit,
                                                    NächsteEinheitExtern   => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return AktuelleEinheit;
      
   end WelcheEinheitArt;
   
   
   
   -- Die Baukosten noch mit in die Bewertung einfließen lassen. äöü
   function NotfalleinheitBauen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      AktuelleEinheitExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NächsteEinheitExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.EinheitenID
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type KampfDatentypen.KampfwerteGroß;
   begin
      
      if
        AktuelleEinheitExtern = EinheitenDatentypen.EinheitenIDMitNullWert'First
      then
         return NächsteEinheitExtern;
         
      elsif
        LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                        IDExtern    => AktuelleEinheitExtern)
        + LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                               IDExtern    => AktuelleEinheitExtern)
        < LeseEinheitenDatenbank.Angriff (RasseExtern => StadtRasseNummerExtern.Rasse,
                                          IDExtern    => NächsteEinheitExtern)
        + LeseEinheitenDatenbank.Verteidigung (RasseExtern => StadtRasseNummerExtern.Rasse,
                                               IDExtern    => NächsteEinheitExtern)
      then
         return NächsteEinheitExtern;
         
      else
         return AktuelleEinheitExtern;
      end if;
      
   end NotfalleinheitBauen;
     
end KIStadtLogik;
