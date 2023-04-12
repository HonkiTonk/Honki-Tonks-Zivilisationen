with KampfDatentypen;
with StadtDatentypen;
with DiplomatieDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with LeseDiplomatie;

with EinheitSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with EinheitenanforderungenLogik;

with KIDatentypen;

with KIEinheitenBauenLogik;
with KIGebaeudeBauenLogik;

package body KIStadtLogik is

   procedure KIStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      case
        GefahrStadt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      case
        LeseStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when KIDatentypen.Keine_Aufgabe_Enum =>
            NeuesBauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                             EinheitBauenExtern       => KIEinheitenBauenLogik.EinheitenBauen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                             GebäudeBauenExtern       => KIGebaeudeBauenLogik.GebäudeBauen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                             NotfallExtern            => False);
            
         when others =>
            return;
      end case;
      
   end KIStadt;
   
   
   
   procedure NeuesBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
         SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               BeschäftigungExtern      => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => (GebäudeBauenExtern.ID, EinheitenKonstanten.LeerID));
         
      elsif
        GebäudeBauenExtern.ID = StadtKonstanten.LeerGebäudeID
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     BeschäftigungExtern      => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     BeschäftigungExtern      => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => (StadtKonstanten.LeerGebäudeID, EinheitBauenExtern.ID));
      
      elsif
        EinheitBauenExtern.Bewertung >= GebäudeBauenExtern.Bewertung
      then
         case
           NotfallExtern
         is
            when True =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     BeschäftigungExtern      => KIDatentypen.Gefahr_Einheit_Bauen_Enum);
               
            when False =>
               SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     BeschäftigungExtern      => KIDatentypen.Einheit_Bauen_Enum);
         end case;
         
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => (StadtKonstanten.LeerGebäudeID, EinheitBauenExtern.ID));

      else
         SchreibeStadtGebaut.KIBeschäftigung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                               BeschäftigungExtern      => KIDatentypen.Gebäude_Bauen_Enum);
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => (GebäudeBauenExtern.ID, EinheitenKonstanten.LeerID));
      end if;
      
   end NeuesBauprojekt;
   
   
   
   function GefahrStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      case
        FeindNahe (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when False =>
            return False;
            
         when True =>
            NotfallEinheit := WelcheEinheitArt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      case
        NotfallEinheit
      is
         when EinheitenDatentypen.EinheitenIDMitNullWert'First =>
            return False;
            
         when others =>
            NeuesBauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                             EinheitBauenExtern       => (NotfallEinheit, 1),
                             GebäudeBauenExtern       => (StadtDatentypen.GebäudeIDMitNullwert'First, 0),
                             NotfallExtern            => True);
            return True;
      end case;
      
   end GefahrStadt;
   
   
   
   function FeindNahe
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is
      use type KartenDatentypen.Kartenfeld;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
   begin
      
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      Umgebungsgröße := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Umgebungsgröße .. Umgebungsgröße loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleSpeziesSuchen (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                                                                    KoordinatenExtern => KartenWert,
                                                                                                    LogikGrafikExtern => True);
                  
                  if
                    FremdeEinheit.Nummer = EinheitenKonstanten.LeerNummer
                  then
                     null;
                     
                  elsif
                    DiplomatieDatentypen.Krieg_Enum /= LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                        SpeziesZweiExtern => FremdeEinheit.Spezies)
                  then
                     null;
                     
                  else
                     case
                       LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => FremdeEinheit.Spezies,
                                                            IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => FremdeEinheit))
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
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is
      use type EinheitenDatentypen.Einheitart_Enum;
   begin
      
      AktuelleEinheit := EinheitenKonstanten.LeerID;
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           EinheitenDatentypen.Arbeiter_Enum = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                    IDExtern      => EinheitenSchleifenwert)
         then
            null;
            
         elsif
           True = EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                     IDExtern                 => EinheitenSchleifenwert)
         then
            AktuelleEinheit := NotfalleinheitBauen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                    AktuelleEinheitExtern    => AktuelleEinheit,
                                                    NächsteEinheitExtern     => EinheitenSchleifenwert);
               
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return AktuelleEinheit;
      
   end WelcheEinheitArt;
   
   
   
   -- Die Baukosten noch mit in die Bewertung einfließen lassen. äöü
   function NotfalleinheitBauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
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
        LeseEinheitenDatenbank.Angriff (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                        IDExtern      => AktuelleEinheitExtern)
        + LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                               IDExtern      => AktuelleEinheitExtern)
        < LeseEinheitenDatenbank.Angriff (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                          IDExtern      => NächsteEinheitExtern)
        + LeseEinheitenDatenbank.Verteidigung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                               IDExtern      => NächsteEinheitExtern)
      then
         return NächsteEinheitExtern;
         
      else
         return AktuelleEinheitExtern;
      end if;
      
   end NotfalleinheitBauen;
     
end KIStadtLogik;
