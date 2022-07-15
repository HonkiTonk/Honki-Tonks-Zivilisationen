pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics;
with Sf.Graphics.Text;

with EinheitenDatentypen; use EinheitenDatentypen;
with GlobaleTexte;
with EinheitenKonstanten;
with TextKonstanten;
with TextaccessVariablen;
with StadtKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenBeschreibungen;
with KampfwerteEinheitErmitteln;
with GrafikEinstellungenSFML;
with StadtInformationenSFML;
with TextberechnungenHoeheSFML;

package body InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition := TextpositionExtern;
      
      -- Diese Zuweisung ist wichtig weil die gefundene Einheit eventuell auf einem Transporter ist.
      EinheitRasseNummer := Allgemeines (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      if
        RasseExtern = EinheitRasseNummerExtern.Rasse
        or
          SpielVariablen.Debug.VolleInformation
      then
         Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummer);
         Angriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Verteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         Rang (EinheitRasseNummerExtern => EinheitRasseNummer);
         Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuelleVerteidigung (EinheitRasseNummerExtern => EinheitRasseNummer);
         AktuellerAngriff (EinheitRasseNummerExtern => EinheitRasseNummer);
         Ladung (EinheitRasseNummerExtern => EinheitRasseNummer);
         
         VolleInformation := True;
         
      else
         VolleInformation := False;
      end if;
      
      DebugInformationen (EinheitRasseNummerExtern => EinheitRasseNummer);
      
      Textposition.y := Textposition.y - TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.EinheitenInformationenAccessArray'Range loop
         
         if
           VolleInformation = False
           and
             TextSchleifenwert > 2
         then
            exit TextSchleife;
            
         else
            Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                               text         => TextaccessVariablen.EinheitenInformationenAccess (TextSchleifenwert));
         end if;
         
      end loop TextSchleife;
      
      return Textposition;
      
   end Einheiten;
   
   
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
            
      case
        LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            EinheitNummer := EinheitRasseNummerExtern.Nummer;
                        
         when others =>
            EinheitNummer := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
            
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (1),
                                         str  => EinheitenBeschreibungen.BeschreibungKurz (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitNummer))));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (1),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
      return (EinheitRasseNummerExtern.Rasse, EinheitNummer);
      
   end Allgemeines;
   
   
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringLebenspunkte (ZahlExtern => LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringLebenspunkte
        (ZahlExtern => LeseEinheitenDatenbank.MaximaleLebenspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                    IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (2),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugLebenspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen 
                                         & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (2),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Lebenspunkte;
   
   
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal (KommazahlExtern => LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := UmwandlungenAdaNachEigenes.BewegungspunkteDarstellungNormal
        (KommazahlExtern => LeseEinheitenDatenbank.MaximaleBewegungspunkte (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                            IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (3),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBewegungspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (3),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Bewegungspunkte;
   
   
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenGebaut.Erfahrungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringKampfwerte
        (ZahlExtern => LeseEinheitenDatenbank.Beförderungsgrenze (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                   IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (4),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugErfahrungspunkte)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (4),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Erfahrungspunkte;
   
   
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (5),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBeschäftigung)) & " "
                                         & EinheitenBeschreibungen.Beschäftigung (LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (5),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Beschäftigung;
   
   
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringArbeitszeit (ZahlExtern => LeseEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (6),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugBeschäftigungszeit)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (6),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Beschäftigungszeit;
   
   
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Angriff (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (7),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAngriff)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (7),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Angriff;
   
   
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenDatenbank.Verteidigung (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                          IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (8),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugVerteidigung)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (8),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Verteidigung;
   
   
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertLinksVomTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => LeseEinheitenGebaut.Rang (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      WertRechtsVomTrennzeichen := ZahlAlsStringKampfwerte
        (ZahlExtern => LeseEinheitenDatenbank.MaximalerRang (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                             IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (9),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugRang)) & " " & To_Wide_Wide_String (Source => WertLinksVomTrennzeichen) & Trennzeichen
                                         & To_Wide_Wide_String (Source => WertRechtsVomTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (9),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Rang;
   
   
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
         
      case
        LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when StadtKonstanten.LeerNummer =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (10),
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugHeimatstadt)) & " "
                                               & To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugKeine)));
               
         when others =>
            Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (10),
                                               str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugHeimatstadt)) & " " 
                                               & StadtInformationenSFML.StadtName (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                              LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern))));
      end case;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (10),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end Heimatstadt;
   
   
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmitteln.AktuelleVerteidigungEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             AngreiferExtern          => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (11),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGegenschlagskraftFeld)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (11),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuelleVerteidigung;
   
   
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      WertOhneTrennzeichen := ZahlAlsStringKampfwerte (ZahlExtern => KampfwerteEinheitErmitteln.AktuellerAngriffEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                         AngreiferExtern          => False));
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (12),
                                         str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugGegenschlagskraft)) & " " & To_Wide_Wide_String (Source => WertOhneTrennzeichen));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (12),
                                    position => Textposition);
      
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
      
   end AktuellerAngriff;
   
   
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern    => IDEinheit)
      is
         when EinheitenKonstanten.LeerKannTransportieren =>
            null;
               
         when others =>
            ErsteAnzeige := True;
            
            LadungSchleife:
            for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                              IDExtern    => IDEinheit) loop
                  
               if
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
                 and
                   ErsteAnzeige
               then
                  ErsteAnzeige := False;
      
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (13),
                                                     str  => To_Wide_Wide_String (Source => GlobaleTexte.Zeug (TextKonstanten.ZeugAktuelleLadung)));
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (13),
                                                position => Textposition);
      
                  Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
                  
                  
      
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (14),
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (14),
                                                position => Textposition);
      
                  Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
                  
               elsif
                 LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlatzExtern              => LadungSchleifenwert)
                 /= EinheitenKonstanten.LeerTransportiert
               then
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EinheitenInformationenAccess (13),
                                                     str  => EinheitenBeschreibungen.BeschreibungKurz
                                                       (IDExtern => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse,
                                                                                                                         LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                            PlatzExtern              => LadungSchleifenwert)))));
                  Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.EinheitenInformationenAccess (13),
                                                position => Textposition);
      
                  Textposition.y := Textposition.y + TextberechnungenHoeheSFML.KleinerZeilenabstand;
                  
               else
                  null;
               end if;
            
            end loop LadungSchleife;
      end case;
      
   end Ladung;
   
   
   
   procedure DebugInformationen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        SpielVariablen.Debug.VolleInformation
      is
         when False =>
            return;
            
         when True =>
            if
              SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Mensch_Spieler_Enum
            then
               null;
               -- Put_Line (LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image & "    "
               --          & LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)'Wide_Wide_Image);
               
            else
               null;
            end if;
      end case;
      
   end DebugInformationen;

end InformationenEinheitenSFML;
