with Spieltexte;
with StadtKonstanten;
with TextnummernKonstanten;
with TextKonstanten;
with GrafikKonstanten;
with Projekteinstellungen;
with SystemDatentypen;
with GrafikRecordKonstanten;
with SpeziesKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;

with EinheitenbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with KampfwerteEinheitErmittelnLogik;
with TextaccessverwaltungssystemGrafik;
with TextskalierungGrafik;

package body EinheitenseitenleisteGrafik is

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionsinformationenExtern : in GrafikRecords.TextpositionLeerzeilenRecord;
      MaximaleTextbreiteExtern : in Float)
      return GrafikRecords.TextpositionLeerzeilenRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Textposition.x := TextpositionsinformationenExtern.Textpositionsinformationen.x;
      Textposition.y := TextpositionsinformationenExtern.Textpositionsinformationen.y;
      Textbreite := TextpositionsinformationenExtern.Textpositionsinformationen.z;
      Leerzeilen := TextpositionsinformationenExtern.Leerzeilen;
      
      if
        SpeziesExtern = SpeziesKonstanten.LeerSpezies
        or
          EinheitSpeziesNummerExtern.Spezies = SpeziesKonstanten.LeerSpezies
      then
         EinheitSpeziesNummer.Nummer := EinheitenKonstanten.LeerWirdTransportiert;
         
      else
         EinheitSpeziesNummer.Nummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
            
      case
        EinheitSpeziesNummer.Nummer
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitSpeziesNummer := EinheitSpeziesNummerExtern;
                        
         when others =>
            EinheitSpeziesNummer.Spezies := EinheitSpeziesNummerExtern.Spezies;
      end case;
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
      case
        IDEinheit
      is
         when EinheitenKonstanten.LeerID =>
            AnzuzeigenderText := (others => TextKonstanten.LeerUnboundedString);
            
         when others =>
            AnzuzeigenderText (1) := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => IDEinheit,
                                                                                                                              SpeziesExtern => EinheitSpeziesNummer.Spezies));
            AnzuzeigenderText (2) := Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                   IDExtern                   => IDEinheit);
            
            if
              SpeziesExtern = EinheitSpeziesNummer.Spezies
              or
                Projekteinstellungen.Debug.VolleInformation
            then
               AnzuzeigenderText (3) := Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                         IDExtern                   => IDEinheit);
               AnzuzeigenderText (4) := Erfahrungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                          IDExtern                   => IDEinheit);
               AnzuzeigenderText (5) := Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                              IDExtern                   => IDEinheit);
               AnzuzeigenderText (6) := Aufgabe (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
               AnzuzeigenderText (7) := Kampfwerte (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
               AnzuzeigenderText (8) := Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
               AnzuzeigenderText (9) := Ladung (EinheitSpeziesNummerExtern => EinheitSpeziesNummer,
                                                IDExtern                   => IDEinheit);
         
            else
               AnzuzeigenderText (3 .. 9) := (others => TextKonstanten.LeerUnboundedString);
            end if;
      end case;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccess'Range loop
         
         if
           AnzuzeigenderText (TextSchleifenwert) = TextKonstanten.LeerUnboundedString
         then
            Leerzeilen := Leerzeilen + 1;
            
         else
            TextaccessverwaltungssystemGrafik.TextPosition (TextaccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                            TextExtern       => To_Wide_Wide_String (Source => AnzuzeigenderText (TextSchleifenwert)),
                                                            PositionExtern   => Textposition);
         
            Textbreite := TextberechnungenBreiteGrafik.TextbreiteAnfangsabstand (TextAccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                                 AbstandExtern    => 2.00 * Textposition.x);
            
            Skalierung.x := TextskalierungGrafik.Breitenskalierung (AktuelleBreiteExtern => Textbreite,
                                                                    ErlaubteBreiteExtern => MaximaleTextbreiteExtern);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
                        
            TextaccessverwaltungssystemGrafik.SkalierenZeichnen (TextaccessExtern => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert),
                                                                 SkalierungExtern => Skalierung);
         
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end if;
         
      end loop TextSchleife;
      
      case
        Projekteinstellungen.Debug.VolleInformation
      is
         when True =>
            null;
            -- PlanZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
      
      return ((Textposition.x, Textposition.y, Textbreite), Leerzeilen);
      
   end Einheiten;
   
   
   
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugLebenspunkte) & " " & LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                              IDExtern      => IDExtern));
        
   end Lebenspunkte;
   
   
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugBewegungspunkte) & LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringBewegungspunkte (ZahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                    IDExtern      => IDExtern));
      
   end Bewegungspunkte;
   
   
   
   function Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugErfahrungspunkte) & LeseEinheitenGebaut.Erfahrungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image
        & TextKonstanten.Trennzeichen & ZahlAlsStringErfahrungspunkte (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                 IDExtern      => IDExtern));
      
   end Erfahrungspunkte;
   
   
   
   function Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugRang) & LeseEinheitenGebaut.Rang (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image & TextKonstanten.Trennzeichen
        & ZahlAlsStringRang (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                 IDExtern      => IDExtern));
      
   end Rang;
   
   
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      Beschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Beschäftigung
      is
         when AufgabenDatentypen.Leer_Aufgabe_Enum =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugBeschäftigung) & TextKonstanten.UmbruchAbstand & EinheitenbeschreibungenGrafik.KurzbeschreibungBeschäftigung (Beschäftigung) & " (" &
              ZahlAlsStringArbeitszeit (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)) & ")";
      end case;
      
   end Aufgabe;
   
   
   
   function Kampfwerte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin
      
      return Spieltexte.Zeug (TextnummernKonstanten.ZeugKampfwerte) & " "
        & ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmittelnLogik.Gesamtangriff (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                TaskExtern                 => SystemDatentypen.Grafik_Task_Enum))
        & " " & TextKonstanten.TrennzeichenUnterschiedlich & " "
        & ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmittelnLogik.Gesamtverteidigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                     TaskExtern                 => SystemDatentypen.Grafik_Task_Enum));
      
   end Kampfwerte;
   
   
   
   -- Kann man das hier auch so anpassen wie bei der Stadt/Einheitenauswahl?
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
   is begin

      Stadtnummer := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
      case
        Stadtnummer
      is
         when StadtKonstanten.LeerNummer =>
            return TextKonstanten.LeerUnboundedString;
               
         when others =>
            return Spieltexte.Zeug (TextnummernKonstanten.ZeugHeimatstadt) & " " & LeseStadtGebaut.Name (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Stadtnummer));
      end case;
      
   end Heimatstadt;
   
   
   
   function Ladung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
   is
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      case
        LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern      => IDExtern)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            return TextKonstanten.LeerUnboundedString;
            
         when others =>
            Beladen := False;
            Ladungstext := Spieltexte.Zeug (TextnummernKonstanten.ZeugAktuelleLadung);
      end case;
                        
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                        IDExtern    => IDExtern) loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlatzExtern                => LadungSchleifenwert);
         
         if
           Ladungsnummer /= EinheitenKonstanten.LeerTransportiert
         then
            Beladen := True;
            Ladungstext := Ladungstext & TextKonstanten.UmbruchAbstand
              & EinheitenbeschreibungenGrafik.Kurzbeschreibung (IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Ladungsnummer)),
                                                                SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
            
         else
            null;
         end if;
            
      end loop LadungSchleife;
      
      case
        Beladen
      is
         when True =>
            return Ladungstext;
            
         when False =>
            return TextKonstanten.LeerUnboundedString;
      end case;
      
   end Ladung;
   
   
   
   -- Das hier mal überarbeiten! äöü
   procedure PlanZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextwerteExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            return;
            
         when others =>
            TextpositionDebug.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
            TextpositionDebug.y := TextwerteExtern.y;
            TextbreiteDebug := TextwerteExtern.x;
      
            Koordinaten := LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
            TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.EinheitenseitenleisteAccess,
                                                                    TextExtern       => ("Nr:" & EinheitSpeziesNummerExtern.Nummer'Wide_Wide_Image & " Z:" & Koordinaten.EAchse'Wide_Wide_Image & ","
                                                                                         & Koordinaten.YAchse'Wide_Wide_Image & "," & Koordinaten.XAchse'Wide_Wide_Image & " Au:"
                                                                                         & LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)'Wide_Wide_Image),
                                                                    PositionExtern   => TextpositionDebug);
            
            TextbreiteDebug := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenseitenleisteAccess,
                                                                                     TextbreiteExtern => TextbreiteDebug);
      end case;
      
      PlanSchleife:
      for PlanSchleifenwert in EinheitenDatentypen.BewegungsplanVorhanden'First .. 10 loop
         
         case
           PlanSchleifenwert mod 2
         is
            when 0 =>
               TextpositionDebug.x := TextbreiteDebug / GrafikKonstanten.Halbierung;
               
            when others =>
               TextpositionDebug.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
               TextpositionDebug.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => TextpositionDebug.y,
                                                                                    ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end case;
         
         Koordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                            PlanschrittExtern          => PlanSchleifenwert);
         
         TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.EinheitenseitenleisteAccess,
                                                                 TextExtern       => PlanSchleifenwert'Wide_Wide_Image & ":" & Koordinaten.EAchse'Wide_Wide_Image & "," & Koordinaten.YAchse'Wide_Wide_Image & ","
                                                                 & Koordinaten.XAchse'Wide_Wide_Image,
                                                                 PositionExtern   => TextpositionDebug);
      
         TextbreiteDebug := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EinheitenseitenleisteAccess,
                                                                                  TextbreiteExtern => TextbreiteDebug);
         
      end loop PlanSchleife;
      
   end PlanZielKoordinaten;
   
end EinheitenseitenleisteGrafik;
